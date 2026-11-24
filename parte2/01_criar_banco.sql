-- =============================================================
-- Hotel Nebula — Script 01: Criação do Banco de Dados e Tabelas
-- =============================================================

CREATE DATABASE IF NOT EXISTS hotel_nebula
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE hotel_nebula;

-- -------------------------------------------------------------
-- Tabela: hospedes
-- Armazena os dados cadastrais de cada hóspede.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hospedes (
    id_hospede      INT           NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(100)  NOT NULL,
    email           VARCHAR(100)  NOT NULL,
    cpf             VARCHAR(14)   NULL,
    telefone        VARCHAR(20)   NULL,
    data_nascimento DATE          NULL,
    nacionalidade   VARCHAR(60)   NOT NULL DEFAULT 'Brasileira',
    endereco        VARCHAR(255)  NULL,
    criado_em       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_hospedes   PRIMARY KEY (id_hospede),
    CONSTRAINT uq_hosp_email UNIQUE (email),
    CONSTRAINT uq_hosp_cpf   UNIQUE (cpf)
);

-- -------------------------------------------------------------
-- Tabela: quartos
-- Representa cada unidade habitacional do hotel.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS quartos (
    id_quarto    INT            NOT NULL AUTO_INCREMENT,
    numero       VARCHAR(10)    NOT NULL,
    tipo         VARCHAR(50)    NOT NULL,
    capacidade   INT            NOT NULL DEFAULT 1,
    preco_diaria DECIMAL(10,2)  NOT NULL,
    status       VARCHAR(20)    NOT NULL DEFAULT 'disponivel',
    andar        VARCHAR(10)    NULL,
    descricao    TEXT           NULL,

    CONSTRAINT pk_quartos        PRIMARY KEY (id_quarto),
    CONSTRAINT uq_quarto_numero  UNIQUE (numero),
    CONSTRAINT chk_capacidade    CHECK (capacidade > 0),
    CONSTRAINT chk_preco         CHECK (preco_diaria > 0),
    CONSTRAINT chk_quarto_status CHECK (status IN ('disponivel', 'ocupado', 'manutencao', 'reservado'))
);

-- -------------------------------------------------------------
-- Tabela: funcionarios
-- Armazena os dados dos colaboradores do hotel.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario INT          NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(100) NOT NULL,
    cargo          VARCHAR(50)  NOT NULL,
    email          VARCHAR(100) NULL,
    telefone       VARCHAR(20)  NULL,
    turno          VARCHAR(20)  NULL,
    data_admissao  DATE         NOT NULL,
    ativo          TINYINT(1)   NOT NULL DEFAULT 1,

    CONSTRAINT pk_funcionarios   PRIMARY KEY (id_funcionario),
    CONSTRAINT uq_func_email     UNIQUE (email),
    CONSTRAINT chk_turno         CHECK (turno IN ('manha', 'tarde', 'noite', 'integral'))
);

-- -------------------------------------------------------------
-- Tabela: reservas
-- Registra a intenção de hospedagem de um hóspede.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva    INT         NOT NULL AUTO_INCREMENT,
    id_hospede    INT         NOT NULL,
    id_quarto     INT         NOT NULL,
    data_checkin  DATE        NOT NULL,
    data_checkout DATE        NOT NULL,
    status        VARCHAR(20) NOT NULL DEFAULT 'confirmada',
    num_hospedes  INT         NOT NULL DEFAULT 1,
    criado_em     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_reservas          PRIMARY KEY (id_reserva),
    CONSTRAINT fk_res_hospede       FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    CONSTRAINT fk_res_quarto        FOREIGN KEY (id_quarto)  REFERENCES quartos(id_quarto),
    CONSTRAINT chk_datas_reserva    CHECK (data_checkout > data_checkin),
    CONSTRAINT chk_num_hospedes     CHECK (num_hospedes > 0),
    CONSTRAINT chk_reserva_status   CHECK (status IN ('confirmada', 'pendente', 'cancelada', 'concluida'))
);

-- -------------------------------------------------------------
-- Tabela: hospedagens
-- Registra a ocupação real após o check-in do hóspede.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hospedagens (
    id_hospedagem  INT          NOT NULL AUTO_INCREMENT,
    id_reserva     INT          NOT NULL,
    id_funcionario INT          NOT NULL,
    checkin_real   DATETIME     NOT NULL,
    checkout_real  DATETIME     NULL,
    observacoes    TEXT         NULL,

    CONSTRAINT pk_hospedagens     PRIMARY KEY (id_hospedagem),
    CONSTRAINT fk_hosp_reserva    FOREIGN KEY (id_reserva)     REFERENCES reservas(id_reserva),
    CONSTRAINT fk_hosp_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    CONSTRAINT uq_hosp_reserva    UNIQUE (id_reserva)
);

-- -------------------------------------------------------------
-- Tabela: pagamentos
-- Registra as transações financeiras de cada hospedagem.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pagamentos (
    id_pagamento   INT            NOT NULL AUTO_INCREMENT,
    id_hospedagem  INT            NOT NULL,
    valor          DECIMAL(10,2)  NOT NULL,
    metodo         VARCHAR(30)    NOT NULL,
    status         VARCHAR(20)    NOT NULL DEFAULT 'pago',
    data_pagamento DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_pagamentos      PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pag_hospedagem  FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem),
    CONSTRAINT chk_valor_pag      CHECK (valor > 0),
    CONSTRAINT chk_metodo         CHECK (metodo IN ('cartao_credito', 'cartao_debito', 'pix', 'dinheiro', 'transferencia')),
    CONSTRAINT chk_pag_status     CHECK (status IN ('pago', 'pendente', 'estornado'))
);

-- -------------------------------------------------------------
-- Tabela: servicos
-- Catálogo de serviços extras disponíveis no hotel.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS servicos (
    id_servico INT            NOT NULL AUTO_INCREMENT,
    nome       VARCHAR(100)   NOT NULL,
    categoria  VARCHAR(50)    NOT NULL,
    preco      DECIMAL(10,2)  NOT NULL,
    descricao  TEXT           NULL,

    CONSTRAINT pk_servicos   PRIMARY KEY (id_servico),
    CONSTRAINT chk_serv_preco CHECK (preco >= 0),
    CONSTRAINT chk_serv_categ CHECK (categoria IN ('alimentacao', 'lazer', 'limpeza', 'transporte', 'outros'))
);

-- -------------------------------------------------------------
-- Tabela: hospedagem_servicos
-- Associa serviços extras a uma hospedagem (N:N).
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hospedagem_servicos (
    id_hosp_servico INT      NOT NULL AUTO_INCREMENT,
    id_hospedagem   INT      NOT NULL,
    id_servico      INT      NOT NULL,
    quantidade      INT      NOT NULL DEFAULT 1,
    solicitado_em   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_hosp_servicos     PRIMARY KEY (id_hosp_servico),
    CONSTRAINT fk_hs_hospedagem     FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem),
    CONSTRAINT fk_hs_servico        FOREIGN KEY (id_servico)    REFERENCES servicos(id_servico),
    CONSTRAINT chk_quantidade       CHECK (quantidade > 0)
);

-- -------------------------------------------------------------
-- Tabela: avaliacoes
-- Armazena o feedback do hóspede após a estadia.
-- -------------------------------------------------------------
CREATE TABLE IF NOT EXISTS avaliacoes (
    id_avaliacao   INT      NOT NULL AUTO_INCREMENT,
    id_hospede     INT      NOT NULL,
    id_quarto      INT      NOT NULL,
    id_hospedagem  INT      NOT NULL,
    nota           INT      NOT NULL,
    comentario     TEXT     NULL,
    data_avaliacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_avaliacoes       PRIMARY KEY (id_avaliacao),
    CONSTRAINT fk_aval_hospede     FOREIGN KEY (id_hospede)    REFERENCES hospedes(id_hospede),
    CONSTRAINT fk_aval_quarto      FOREIGN KEY (id_quarto)     REFERENCES quartos(id_quarto),
    CONSTRAINT fk_aval_hospedagem  FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem),
    CONSTRAINT uq_aval_hospedagem  UNIQUE (id_hospedagem),
    CONSTRAINT chk_nota            CHECK (nota BETWEEN 1 AND 5)
);
