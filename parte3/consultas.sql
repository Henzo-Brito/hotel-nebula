-- =============================================================
-- Hotel Nebula — Script 03: Consultas de Gestão (Parte 3)
-- =============================================================

USE hotel_nebula;

-- -------------------------------------------------------------------
-- 1. Quartos disponíveis em um período específico
--    Lógica: um quarto está indisponível no período [X, Y] se existe
--    alguma reserva confirmada/concluída cujas datas se sobrepõem.
--    Duas datas se sobrepõem quando: checkin < Y  AND checkout > X.
-- -------------------------------------------------------------------
SELECT
    q.id_quarto,
    q.numero,
    q.tipo,
    q.capacidade,
    q.preco_diaria,
    q.andar,
    q.descricao
FROM quartos q
WHERE q.status NOT IN ('manutencao')
  AND q.id_quarto NOT IN (
        SELECT r.id_quarto
        FROM reservas r
        WHERE r.status IN ('confirmada', 'concluida', 'pendente')
          AND r.data_checkin  < '2025-02-20'   -- substitua pela data de checkout desejada
          AND r.data_checkout > '2025-02-10'   -- substitua pela data de checkin desejada
      )
ORDER BY q.tipo, q.preco_diaria;


-- -------------------------------------------------------------------
-- 2. Hóspedes que mais realizaram reservas
-- -------------------------------------------------------------------
SELECT
    h.id_hospede,
    h.nome,
    h.email,
    h.nacionalidade,
    COUNT(r.id_reserva)                                    AS total_reservas,
    SUM(CASE WHEN r.status = 'concluida' THEN 1 ELSE 0 END) AS reservas_concluidas,
    SUM(CASE WHEN r.status = 'cancelada' THEN 1 ELSE 0 END) AS reservas_canceladas
FROM hospedes h
JOIN reservas r ON r.id_hospede = h.id_hospede
GROUP BY h.id_hospede, h.nome, h.email, h.nacionalidade
ORDER BY total_reservas DESC;


-- -------------------------------------------------------------------
-- 3. Faturamento por mês
--    Soma dos pagamentos com status 'pago' agrupados por ano/mês.
-- -------------------------------------------------------------------
SELECT
    DATE_FORMAT(p.data_pagamento, '%Y-%m') AS ano_mes,
    COUNT(DISTINCT p.id_hospedagem)        AS hospedagens_faturadas,
    COUNT(p.id_pagamento)                  AS num_transacoes,
    SUM(p.valor)                           AS faturamento_total,
    AVG(p.valor)                           AS ticket_medio
FROM pagamentos p
WHERE p.status = 'pago'
GROUP BY DATE_FORMAT(p.data_pagamento, '%Y-%m')
ORDER BY ano_mes;


-- -------------------------------------------------------------------
-- 4. Serviços extras mais consumidos
--    Considera a quantidade total solicitada e o número de hospedagens
--    distintas em que o serviço apareceu.
-- -------------------------------------------------------------------
SELECT
    s.id_servico,
    s.nome,
    s.categoria,
    s.preco,
    COUNT(hs.id_hosp_servico)       AS vezes_solicitado,
    SUM(hs.quantidade)              AS quantidade_total,
    SUM(hs.quantidade * s.preco)    AS receita_gerada
FROM servicos s
JOIN hospedagem_servicos hs ON hs.id_servico = s.id_servico
GROUP BY s.id_servico, s.nome, s.categoria, s.preco
ORDER BY quantidade_total DESC;


-- -------------------------------------------------------------------
-- 5. Quartos com melhores avaliações
--    Média de nota e total de avaliações por quarto.
-- -------------------------------------------------------------------
SELECT
    q.id_quarto,
    q.numero,
    q.tipo,
    q.andar,
    q.preco_diaria,
    COUNT(a.id_avaliacao)   AS total_avaliacoes,
    AVG(a.nota)             AS media_nota,
    MIN(a.nota)             AS nota_minima,
    MAX(a.nota)             AS nota_maxima
FROM quartos q
JOIN avaliacoes a ON a.id_quarto = q.id_quarto
GROUP BY q.id_quarto, q.numero, q.tipo, q.andar, q.preco_diaria
ORDER BY media_nota DESC, total_avaliacoes DESC;


-- -------------------------------------------------------------------
-- 6. Reservas canceladas
--    Lista detalhada com hóspede, quarto e período.
-- -------------------------------------------------------------------
SELECT
    r.id_reserva,
    h.nome                                        AS hospede,
    h.email,
    q.numero                                      AS quarto,
    q.tipo                                        AS tipo_quarto,
    r.data_checkin,
    r.data_checkout,
    DATEDIFF(r.data_checkout, r.data_checkin)     AS diarias_previstas,
    r.criado_em                                   AS reserva_criada_em
FROM reservas r
JOIN hospedes   h ON h.id_hospede = r.id_hospede
JOIN quartos    q ON q.id_quarto  = r.id_quarto
WHERE r.status = 'cancelada'
ORDER BY r.criado_em DESC;


-- -------------------------------------------------------------------
-- 7. Hospedagens atendidas por cada funcionário
--    Conta quantos check-ins cada funcionário realizou e o período.
-- -------------------------------------------------------------------
SELECT
    f.id_funcionario,
    f.nome                        AS funcionario,
    f.cargo,
    f.turno,
    f.ativo,
    COUNT(ho.id_hospedagem)       AS total_hospedagens,
    MIN(ho.checkin_real)          AS primeiro_checkin,
    MAX(ho.checkin_real)          AS ultimo_checkin
FROM funcionarios f
LEFT JOIN hospedagens ho ON ho.id_funcionario = f.id_funcionario
GROUP BY f.id_funcionario, f.nome, f.cargo, f.turno, f.ativo
ORDER BY total_hospedagens DESC;


-- -------------------------------------------------------------------
-- CONSULTAS EXTRAS
-- -------------------------------------------------------------------

-- 8. Receita total por tipo de quarto
SELECT
    q.tipo,
    COUNT(DISTINCT ho.id_hospedagem)  AS hospedagens,
    SUM(p.valor)                      AS receita_total,
    AVG(p.valor)                      AS receita_media_por_hospedagem
FROM quartos q
JOIN reservas    r  ON r.id_quarto      = q.id_quarto
JOIN hospedagens ho ON ho.id_reserva    = r.id_reserva
JOIN pagamentos  p  ON p.id_hospedagem  = ho.id_hospedagem
WHERE p.status = 'pago'
GROUP BY q.tipo
ORDER BY receita_total DESC;


-- 9. Hóspedes sem nenhuma avaliação registrada
--    Útil para campanhas de pós-estadia solicitando feedback.
SELECT
    h.id_hospede,
    h.nome,
    h.email,
    COUNT(ho.id_hospedagem) AS hospedagens_sem_avaliacao
FROM hospedes h
JOIN reservas    r  ON r.id_hospede  = h.id_hospede AND r.status = 'concluida'
JOIN hospedagens ho ON ho.id_reserva = r.id_reserva
LEFT JOIN avaliacoes a ON a.id_hospedagem = ho.id_hospedagem
WHERE a.id_avaliacao IS NULL
GROUP BY h.id_hospede, h.nome, h.email
ORDER BY hospedagens_sem_avaliacao DESC;


-- 10. Tempo médio de estadia por tipo de quarto
SELECT
    q.tipo,
    COUNT(ho.id_hospedagem)                                                AS total_estadias,
    AVG(DATEDIFF(ho.checkout_real, ho.checkin_real))                       AS media_dias,
    MIN(DATEDIFF(ho.checkout_real, ho.checkin_real))                       AS minimo_dias,
    MAX(DATEDIFF(ho.checkout_real, ho.checkin_real))                       AS maximo_dias
FROM quartos q
JOIN reservas    r  ON r.id_quarto      = q.id_quarto
JOIN hospedagens ho ON ho.id_reserva    = r.id_reserva
WHERE ho.checkout_real IS NOT NULL
GROUP BY q.tipo
ORDER BY media_dias DESC;


-- 11. Resumo financeiro por forma de pagamento
SELECT
    p.metodo,
    COUNT(p.id_pagamento)  AS num_transacoes,
    SUM(p.valor)           AS valor_total,
    AVG(p.valor)           AS valor_medio
FROM pagamentos p
WHERE p.status = 'pago'
GROUP BY p.metodo
ORDER BY valor_total DESC;
