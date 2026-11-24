# Parte 1 — Diagrama Entidade-Relacionamento

## Diagrama ER (Mermaid)

```mermaid
erDiagram
    HOSPEDES {
        int    id_hospede       PK
        string nome
        string email
        string cpf
        string telefone
        date   data_nascimento
        string nacionalidade
        string endereco
        datetime criado_em
    }

    QUARTOS {
        int     id_quarto    PK
        string  numero
        string  tipo
        int     capacidade
        decimal preco_diaria
        string  status
        string  andar
        string  descricao
    }

    RESERVAS {
        int      id_reserva    PK
        int      id_hospede    FK
        int      id_quarto     FK
        date     data_checkin
        date     data_checkout
        string   status
        int      num_hospedes
        datetime criado_em
    }

    HOSPEDAGENS {
        int      id_hospedagem  PK
        int      id_reserva     FK
        int      id_funcionario FK
        datetime checkin_real
        datetime checkout_real
        string   observacoes
    }

    PAGAMENTOS {
        int      id_pagamento   PK
        int      id_hospedagem  FK
        decimal  valor
        string   metodo
        string   status
        datetime data_pagamento
    }

    FUNCIONARIOS {
        int    id_funcionario  PK
        string nome
        string cargo
        string email
        string telefone
        string turno
        date   data_admissao
        bool   ativo
    }

    SERVICOS {
        int     id_servico  PK
        string  nome
        string  categoria
        decimal preco
        string  descricao
    }

    HOSPEDAGEM_SERVICOS {
        int      id_hosp_servico  PK
        int      id_hospedagem    FK
        int      id_servico       FK
        int      quantidade
        datetime solicitado_em
    }

    AVALIACOES {
        int      id_avaliacao   PK
        int      id_hospede     FK
        int      id_quarto      FK
        int      id_hospedagem  FK
        int      nota
        text     comentario
        datetime data_avaliacao
    }

    HOSPEDES           ||--o{ RESERVAS            : "faz"
    QUARTOS            ||--o{ RESERVAS            : "recebe"
    RESERVAS           ||--||  HOSPEDAGENS        : "gera"
    HOSPEDAGENS        ||--o{ PAGAMENTOS          : "gera"
    FUNCIONARIOS       ||--o{ HOSPEDAGENS         : "atende"
    HOSPEDAGENS        ||--o{ HOSPEDAGEM_SERVICOS : "solicita"
    SERVICOS           ||--o{ HOSPEDAGEM_SERVICOS : "compõe"
    HOSPEDES           ||--o{ AVALIACOES          : "escreve"
    QUARTOS            ||--o{ AVALIACOES          : "recebe"
    HOSPEDAGENS        ||--o{ AVALIACOES          : "origina"
```

---

> Para visualizar o diagrama, cole o bloco Mermaid em [mermaid.live](https://mermaid.live) ou use qualquer editor com suporte a Mermaid (VS Code, GitHub, Notion).
