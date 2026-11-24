# Parte 2 — Documentação da Estrutura do Banco de Dados

## Banco de dados

**Nome:** `hotel_nebula`  
**Charset:** `utf8mb4` / `utf8mb4_unicode_ci`  
**SGBD:** MySQL 8+

---

## Tabelas e suas responsabilidades

### `hospedes`
Armazena o cadastro de cada pessoa que utiliza os serviços do hotel. Email e CPF são únicos para evitar duplicações. O CPF é opcional para hóspedes estrangeiros.

**Campos-chave:** `id_hospede` (PK), `email` (UNIQUE), `cpf` (UNIQUE)

---

### `quartos`
Representa cada unidade habitacional. O campo `status` controla a disponibilidade operacional em tempo real: `disponivel`, `ocupado`, `reservado` ou `manutencao`.

**Campos-chave:** `id_quarto` (PK), `numero` (UNIQUE)  
**Restrições:** `capacidade > 0`, `preco_diaria > 0`, `status IN (...)` via CHECK

---

### `funcionarios`
Registra os colaboradores. O campo `ativo` permite desativar um funcionário sem excluí-lo, preservando o histórico de hospedagens que atendeu.

**Campos-chave:** `id_funcionario` (PK), `email` (UNIQUE)  
**Restrições:** `turno IN ('manha', 'tarde', 'noite', 'integral')`

---

### `reservas`
Registra a **intenção** de hospedagem antes do check-in. Uma reserva pode ser `confirmada`, `pendente`, `cancelada` ou `concluida`. Reservas canceladas não geram hospedagem.

**Campos-chave:** `id_reserva` (PK)  
**FK:** `id_hospede → hospedes`, `id_quarto → quartos`  
**Restrições:** `data_checkout > data_checkin`, `num_hospedes > 0`

---

### `hospedagens`
Registra a **ocupação efetiva** do quarto após o check-in. Possui relação 1:1 com `reservas` (UNIQUE em `id_reserva`). O funcionário que realizou o check-in fica vinculado aqui.

**Campos-chave:** `id_hospedagem` (PK), `id_reserva` (UNIQUE)  
**FK:** `id_reserva → reservas`, `id_funcionario → funcionarios`

---

### `pagamentos`
Cada hospedagem pode gerar mais de um pagamento (por exemplo: diárias pagas no check-in e serviços extras pagos no check-out). O campo `status` permite rastrear estornos.

**Campos-chave:** `id_pagamento` (PK)  
**FK:** `id_hospedagem → hospedagens`  
**Restrições:** `valor > 0`, `metodo IN (...)`, `status IN (...)`

---

### `servicos`
Catálogo estático dos serviços extras oferecidos (café, spa, transporte, etc.). Serviços com preço zero (ex: berço) são permitidos via `preco >= 0`.

**Campos-chave:** `id_servico` (PK)  
**Restrições:** `categoria IN ('alimentacao', 'lazer', 'limpeza', 'transporte', 'outros')`

---

### `hospedagem_servicos`
Tabela associativa N:N entre `hospedagens` e `servicos`. Registra cada solicitação de serviço com a quantidade pedida e o momento da solicitação.

**Campos-chave:** `id_hosp_servico` (PK)  
**FK:** `id_hospedagem → hospedagens`, `id_servico → servicos`  
**Restrições:** `quantidade > 0`

---

### `avaliacoes`
Uma hospedagem pode originar no máximo uma avaliação (UNIQUE em `id_hospedagem`). A nota é um inteiro de 1 a 5. O hóspede e o quarto ficam referenciados diretamente para facilitar consultas de média por quarto.

**Campos-chave:** `id_avaliacao` (PK), `id_hospedagem` (UNIQUE)  
**FK:** `id_hospede → hospedes`, `id_quarto → quartos`, `id_hospedagem → hospedagens`  
**Restrições:** `nota BETWEEN 1 AND 5`

---

## Diagrama de dependências entre tabelas

```
hospedes ──────────────────────────────┐
    │                                  │
    ▼                                  ▼
  reservas ──► hospedagens ◄── funcionarios
                   │
        ┌──────────┼──────────┐
        ▼          ▼          ▼
    pagamentos  hosp_serv  avaliacoes
                   │
                   ▼
                servicos
```

---

## Decisões de projeto

| Decisão | Justificativa |
|---|---|
| `hospedagens.id_reserva` é UNIQUE | Garante relação 1:1 entre reserva e hospedagem no banco, não só na aplicação. |
| `avaliacoes.id_hospedagem` é UNIQUE | Impede avaliações duplicadas para a mesma estadia. |
| `funcionarios.ativo` como flag | Preserva o histórico: deletar um funcionário quebraria FKs em `hospedagens`. |
| `cpf` nullable em `hospedes` | Hóspedes estrangeiros não possuem CPF brasileiro. |
| `pagamentos` permite múltiplos por hospedagem | Comporta pagamentos parcelados, cobranças adicionais e reembolsos. |
| `servicos.preco >= 0` | Serviços cortesia (preço zero) são válidos no catálogo. |

---

## Scripts

| Arquivo | Conteúdo |
|---|---|
| `01_criar_banco.sql` | Criação do banco e de todas as tabelas com PKs, FKs e restrições. |
| `02_inserir_dados.sql` | Inserção de dados de teste: 10 hóspedes, 10 quartos, 9 funcionários, 10 serviços, 16 reservas, 10 hospedagens, 11 pagamentos, 23 registros de serviços e 10 avaliações. |
