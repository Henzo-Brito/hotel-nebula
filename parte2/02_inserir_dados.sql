-- =============================================================
-- Hotel Nebula — Script 02: Inserção de Dados de Teste
-- =============================================================

USE hotel_nebula;

-- -------------------------------------------------------------
-- Hóspedes
-- -------------------------------------------------------------
INSERT INTO hospedes (nome, email, cpf, telefone, data_nascimento, nacionalidade, endereco) VALUES
('Ana Luiza Ferreira',    'ana.ferreira@email.com',   '111.222.333-44', '(11) 91111-2222', '1990-03-15', 'Brasileira',  'Rua das Flores, 10, São Paulo, SP'),
('Carlos Eduardo Lima',  'carlos.lima@email.com',    '222.333.444-55', '(21) 92222-3333', '1985-07-22', 'Brasileira',  'Av. Brasil, 200, Rio de Janeiro, RJ'),
('Mariana Costa',        'mariana.costa@email.com',  '333.444.555-66', '(31) 93333-4444', '1992-11-08', 'Brasileira',  'Rua do Comércio, 55, Belo Horizonte, MG'),
('Pedro Alves Santos',   'pedro.santos@email.com',   '444.555.666-77', '(41) 94444-5555', '1978-01-30', 'Brasileira',  'Rua XV de Novembro, 300, Curitiba, PR'),
('Sophie Müller',        'sophie.muller@email.com',  NULL,             '+49 170 1234567', '1995-06-14', 'Alemã',       'Berliner Str. 42, Berlim, Alemanha'),
('Fernanda Rocha',       'fernanda.rocha@email.com', '555.666.777-88', '(51) 95555-6666', '1988-09-03', 'Brasileira',  'Av. Ipiranga, 150, Porto Alegre, RS'),
('Ricardo Mendes',       'ricardo.mendes@email.com', '666.777.888-99', '(85) 96666-7777', '1983-12-19', 'Brasileira',  'Rua Floriano Peixoto, 80, Fortaleza, CE'),
('Juliana Neves',        'juliana.neves@email.com',  '777.888.999-00', '(71) 97777-8888', '1997-04-27', 'Brasileira',  'Rua do Paraíso, 22, Salvador, BA'),
('Thomas Dupont',        'thomas.dupont@email.com',  NULL,             '+33 6 12 34 56 78','1991-08-11', 'Francesa',    '10 Rue de la Paix, Paris, França'),
('Larissa Oliveira',     'larissa.oliveira@email.com','888.999.000-11','(62) 98888-9999', '1994-02-05', 'Brasileira',  'Setor Bueno, Qd. 10, Goiânia, GO');

-- -------------------------------------------------------------
-- Quartos
-- -------------------------------------------------------------
INSERT INTO quartos (numero, tipo, capacidade, preco_diaria, status, andar, descricao) VALUES
('101', 'Solteiro',  1, 180.00,  'disponivel',  '1', 'Quarto simples com cama de solteiro, ar-condicionado e TV.'),
('102', 'Solteiro',  1, 180.00,  'disponivel',  '1', 'Quarto simples com vista para o jardim.'),
('201', 'Duplo',     2, 290.00,  'disponivel',  '2', 'Quarto duplo com duas camas de solteiro, frigobar e Wi-Fi.'),
('202', 'Duplo',     2, 290.00,  'reservado',   '2', 'Quarto duplo com cama de casal e banheira.'),
('203', 'Duplo',     2, 310.00,  'disponivel',  '2', 'Quarto duplo com varanda e vista para a piscina.'),
('301', 'Suite',     3, 480.00,  'ocupado',     '3', 'Suite com sala de estar, jacuzzi e vista panorâmica.'),
('302', 'Suite',     3, 480.00,  'disponivel',  '3', 'Suite executiva com home office e lounge privativo.'),
('401', 'Luxo',      4, 750.00,  'disponivel',  '4', 'Quarto de luxo com dois banheiros, sala e cozinha compacta.'),
('402', 'Luxo',      4, 750.00,  'manutencao',  '4', 'Quarto de luxo em manutenção preventiva.'),
('103', 'Solteiro',  1, 190.00,  'disponivel',  '1', 'Quarto solteiro adaptado para pessoas com mobilidade reduzida.');

-- -------------------------------------------------------------
-- Funcionários
-- -------------------------------------------------------------
INSERT INTO funcionarios (nome, cargo, email, telefone, turno, data_admissao, ativo) VALUES
('Beatriz Souza',     'Recepcionista', 'beatriz.souza@hotelnebula.com',   '(11) 3000-1001', 'manha',    '2021-03-10', 1),
('Rafael Torres',     'Recepcionista', 'rafael.torres@hotelnebula.com',   '(11) 3000-1002', 'tarde',    '2020-07-15', 1),
('Camila Pereira',    'Recepcionista', 'camila.pereira@hotelnebula.com',  '(11) 3000-1003', 'noite',    '2022-01-20', 1),
('Diego Martins',     'Gerente',       'diego.martins@hotelnebula.com',   '(11) 3000-1004', 'integral', '2018-05-02', 1),
('Patrícia Gomes',    'Camareira',     'patricia.gomes@hotelnebula.com',  '(11) 3000-1005', 'manha',    '2019-11-08', 1),
('Marcos Vieira',     'Camareiro',     'marcos.vieira@hotelnebula.com',   '(11) 3000-1006', 'tarde',    '2021-09-14', 1),
('Renata Figueiredo', 'Recepcionista', 'renata.figueiredo@hotelnebula.com','(11) 3000-1007','manha',    '2023-02-01', 1),
('André Carvalho',    'Manutenção',    'andre.carvalho@hotelnebula.com',  '(11) 3000-1008', 'integral', '2017-06-30', 1),
('Lucia Barros',      'Recepcionista', 'lucia.barros@hotelnebula.com',    '(11) 3000-1009', 'noite',    '2016-04-18', 0);  -- inativa

-- -------------------------------------------------------------
-- Serviços
-- -------------------------------------------------------------
INSERT INTO servicos (nome, categoria, preco, descricao) VALUES
('Café da Manhã',          'alimentacao', 35.00,  'Buffet completo com itens regionais e internacionais, das 7h às 10h.'),
('Meia Pensão',            'alimentacao', 90.00,  'Inclui café da manhã e jantar no restaurante do hotel.'),
('Serviço de Quarto 24h',  'alimentacao', 20.00,  'Taxa de entrega de pedidos do cardápio ao quarto, disponível 24 horas.'),
('Transfer Aeroporto',     'transporte',  80.00,  'Traslado em veículo executivo entre o hotel e o aeroporto.'),
('Aluguel de Bicicleta',   'lazer',       30.00,  'Bicicleta disponível por período de 4 horas.'),
('Acesso à Spa',           'lazer',      120.00,  'Acesso por um dia completo à spa com sauna, piscina aquecida e salas de relaxamento.'),
('Lavanderia Expressa',    'limpeza',     50.00,  'Limpeza e devolução em até 4 horas para até 5 peças.'),
('Estacionamento',         'outros',      40.00,  'Vaga coberta por diária para um veículo.'),
('Late Check-out',         'outros',      60.00,  'Extensão do check-out até as 16h.'),
('Baby Cot',               'outros',       0.00,  'Berço adicional para bebês, mediante disponibilidade (gratuito).');

-- -------------------------------------------------------------
-- Reservas
-- -------------------------------------------------------------
INSERT INTO reservas (id_hospede, id_quarto, data_checkin, data_checkout, status, num_hospedes) VALUES
-- Reservas concluídas (passado)
(1,  1, '2024-10-01', '2024-10-04', 'concluida', 1),   -- id 1
(2,  3, '2024-10-05', '2024-10-08', 'concluida', 2),   -- id 2
(3,  6, '2024-10-10', '2024-10-15', 'concluida', 2),   -- id 3
(4,  8, '2024-10-20', '2024-10-25', 'concluida', 3),   -- id 4
(5,  2, '2024-11-01', '2024-11-03', 'concluida', 1),   -- id 5
(6,  5, '2024-11-10', '2024-11-14', 'concluida', 2),   -- id 6
(7,  7, '2024-11-20', '2024-11-23', 'concluida', 2),   -- id 7
(8,  1, '2024-12-01', '2024-12-05', 'concluida', 1),   -- id 8
(1,  3, '2024-12-10', '2024-12-14', 'concluida', 2),   -- id 9  (Ana faz 2ª reserva)
(9,  5, '2024-12-20', '2024-12-27', 'concluida', 2),   -- id 10
-- Reservas canceladas
(2,  6, '2024-11-05', '2024-11-08', 'cancelada', 2),   -- id 11
(10, 8, '2024-11-15', '2024-11-18', 'cancelada', 2),   -- id 12
(3,  7, '2025-01-10', '2025-01-13', 'cancelada', 1),   -- id 13
-- Reservas futuras confirmadas
(1,  7, '2025-02-10', '2025-02-14', 'confirmada', 1),  -- id 14 (Ana faz 3ª reserva)
(4,  4, '2025-02-15', '2025-02-18', 'confirmada', 2),  -- id 15
(10, 3, '2025-03-01', '2025-03-05', 'confirmada', 2);  -- id 16

-- -------------------------------------------------------------
-- Hospedagens  (apenas reservas com status 'concluida')
-- Recepcionistas que fizeram o check-in: ids 1, 2, 3, 7
-- -------------------------------------------------------------
INSERT INTO hospedagens (id_reserva, id_funcionario, checkin_real, checkout_real, observacoes) VALUES
(1,  1, '2024-10-01 14:10:00', '2024-10-04 11:30:00', NULL),
(2,  2, '2024-10-05 15:00:00', '2024-10-08 10:45:00', 'Hóspede solicitou cama extra.'),
(3,  3, '2024-10-10 13:50:00', '2024-10-15 11:00:00', NULL),
(4,  1, '2024-10-20 16:00:00', '2024-10-25 12:00:00', 'VIP — preferência por andar alto.'),
(5,  7, '2024-11-01 14:30:00', '2024-11-03 11:15:00', NULL),
(6,  2, '2024-11-10 15:20:00', '2024-11-14 10:30:00', NULL),
(7,  1, '2024-11-20 14:00:00', '2024-11-23 11:00:00', 'Cliente pediu frigobar abastecido.'),
(8,  3, '2024-12-01 15:45:00', '2024-12-05 12:00:00', NULL),
(9,  7, '2024-12-10 14:20:00', '2024-12-14 11:30:00', 'Segunda visita da hóspede.'),
(10, 2, '2024-12-20 16:00:00', '2024-12-27 10:00:00', 'Período de fim de ano.');

-- -------------------------------------------------------------
-- Pagamentos
-- (valor = diárias × preco_diaria, podendo ter extras)
-- -------------------------------------------------------------
INSERT INTO pagamentos (id_hospedagem, valor, metodo, status, data_pagamento) VALUES
-- Hospedagem 1: quarto 101 (R$180) × 3 dias = R$540
(1,  540.00, 'cartao_credito', 'pago', '2024-10-04 11:45:00'),
-- Hospedagem 2: quarto 201 (R$290) × 3 dias = R$870
(2,  870.00, 'pix',            'pago', '2024-10-08 11:00:00'),
-- Hospedagem 3: quarto 301 (R$480) × 5 dias = R$2400 + extras
(3, 2400.00, 'cartao_credito', 'pago', '2024-10-15 11:30:00'),
(3,  350.00, 'pix',            'pago', '2024-10-15 11:30:00'),  -- serviços extras
-- Hospedagem 4: quarto 401 (R$750) × 5 dias = R$3750
(4, 3750.00, 'cartao_debito',  'pago', '2024-10-25 12:30:00'),
-- Hospedagem 5: quarto 102 (R$180) × 2 dias = R$360
(5,  360.00, 'dinheiro',       'pago', '2024-11-03 11:30:00'),
-- Hospedagem 6: quarto 203 (R$310) × 4 dias = R$1240
(6, 1240.00, 'pix',            'pago', '2024-11-14 11:00:00'),
-- Hospedagem 7: quarto 302 (R$480) × 3 dias = R$1440
(7, 1440.00, 'cartao_credito', 'pago', '2024-11-23 11:30:00'),
-- Hospedagem 8: quarto 101 (R$180) × 4 dias = R$720
(8,  720.00, 'transferencia',  'pago', '2024-12-05 12:30:00'),
-- Hospedagem 9: quarto 201 (R$290) × 4 dias = R$1160
(9, 1160.00, 'pix',            'pago', '2024-12-14 12:00:00'),
-- Hospedagem 10: quarto 203 (R$310) × 7 dias = R$2170
(10,2170.00, 'cartao_credito', 'pago', '2024-12-27 10:30:00'),
(10, 200.00, 'cartao_credito', 'pago', '2024-12-27 10:30:00');  -- gorjeta/extras

-- -------------------------------------------------------------
-- Hospedagem ↔ Serviços
-- -------------------------------------------------------------
INSERT INTO hospedagem_servicos (id_hospedagem, id_servico, quantidade, solicitado_em) VALUES
-- Hospedagem 1 (Ana, q.101)
(1, 1, 3, '2024-10-01 08:00:00'),  -- Café da Manhã × 3
(1, 8, 3, '2024-10-01 14:30:00'),  -- Estacionamento × 3
-- Hospedagem 2 (Carlos, q.201)
(2, 1, 3, '2024-10-05 08:00:00'),  -- Café da Manhã × 3
(2, 4, 1, '2024-10-05 15:30:00'),  -- Transfer Aeroporto
-- Hospedagem 3 (Mariana, q.301 — Suite)
(3, 2, 5, '2024-10-10 08:00:00'),  -- Meia Pensão × 5
(3, 6, 2, '2024-10-11 10:00:00'),  -- Acesso à Spa × 2
(3, 7, 1, '2024-10-13 09:00:00'),  -- Lavanderia Expressa
-- Hospedagem 4 (Pedro, q.401 — Luxo)
(4, 2, 5, '2024-10-20 08:00:00'),  -- Meia Pensão × 5
(4, 6, 3, '2024-10-21 10:00:00'),  -- Spa × 3
(4, 4, 1, '2024-10-20 16:30:00'),  -- Transfer
(4, 8, 5, '2024-10-20 16:30:00'),  -- Estacionamento × 5
-- Hospedagem 5 (Sophie, q.102)
(5, 1, 2, '2024-11-01 08:00:00'),  -- Café da Manhã × 2
(5, 5, 1, '2024-11-02 10:00:00'),  -- Bicicleta
-- Hospedagem 6 (Fernanda, q.203)
(6, 1, 4, '2024-11-10 08:00:00'),  -- Café da Manhã × 4
(6, 7, 1, '2024-11-12 09:00:00'),  -- Lavanderia
-- Hospedagem 7 (Ricardo, q.302 — Suite)
(7, 3, 3, '2024-11-20 20:00:00'),  -- Serviço de Quarto × 3
(7, 1, 3, '2024-11-20 08:00:00'),  -- Café × 3
(7, 9, 1, '2024-11-23 09:00:00'),  -- Late Check-out
-- Hospedagem 9 (Ana, q.201 — 2ª estadia)
(9, 1, 4, '2024-12-10 08:00:00'),  -- Café × 4
(9, 4, 1, '2024-12-14 10:30:00'),  -- Transfer
-- Hospedagem 10 (Thomas, q.203)
(10, 2, 7, '2024-12-20 08:00:00'), -- Meia Pensão × 7
(10, 6, 2, '2024-12-22 10:00:00'), -- Spa × 2
(10, 8, 7, '2024-12-20 16:30:00'); -- Estacionamento × 7

-- -------------------------------------------------------------
-- Avaliações (uma por hospedagem, apenas estadias concluídas)
-- -------------------------------------------------------------
INSERT INTO avaliacoes (id_hospede, id_quarto, id_hospedagem, nota, comentario, data_avaliacao) VALUES
(1,  1, 1,  5, 'Ótima estadia! Quarto limpo e confortável. Atendimento impecável.', '2024-10-05 09:00:00'),
(2,  3, 2,  4, 'Muito bom. Quarto espaçoso, apenas o Wi-Fi estava lento.', '2024-10-09 10:00:00'),
(3,  6, 3,  5, 'Suite incrível, jacuzzi perfeita. Voltarei com certeza!', '2024-10-16 08:00:00'),
(4,  8, 4,  4, 'Luxo de verdade. Esperava café da manhã mais variado.', '2024-10-26 11:00:00'),
(5,  2, 5,  3, 'Razoável. Quarto ok, mas o banheiro precisava de reparos.', '2024-11-04 14:00:00'),
(6,  5, 6,  5, 'Adorei a varanda com vista para a piscina. Perfeito!', '2024-11-15 09:00:00'),
(7,  7, 7,  4, 'Suite muito boa. Serviço de quarto um pouco demorado.', '2024-11-24 10:00:00'),
(8,  1, 8,  5, 'Já é a segunda vez que fico nesse hotel. Sempre excelente!', '2024-12-06 09:30:00'),
(1,  3, 9,  5, 'Mais uma estadia perfeita. Me sinto em casa aqui.', '2024-12-15 08:00:00'),
(9,  5, 10, 4, 'Período de festas bem organizado. Equipe muito simpática.', '2024-12-28 10:00:00');
