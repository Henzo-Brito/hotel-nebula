# Hotel Nebula — Projeto de Banco de Dados

Projeto de modelagem e implementação de banco de dados relacional para a rede **Hotel Nebula**, desenvolvido em três partes.

---

## Estrutura do repositório

```
hotel-nebula/
├── parte1/
│   ├── diagrama_er.md                 # Diagrama ER em Mermaid
│   └── entidades_e_relacionamentos.md # Entidades, relacionamentos e regras de negócio
│
├── parte2/
│   ├── 01_criar_banco.sql             # Criação do banco e de todas as tabelas
│   ├── 02_inserir_dados.sql           # Dados de teste
│   └── 03_documentacao.md             # Documentação da estrutura
│
└── parte3/
    └── consultas.sql                  # Consultas de gestão
```

---

## Como executar

1. Ter o MySQL 8+ instalado e em execução.
2. Executar os scripts **na ordem**:

```bash
mysql -u root -p < parte2/01_criar_banco.sql
mysql -u root -p < parte2/02_inserir_dados.sql
mysql -u root -p hotel_nebula < parte3/consultas.sql
```

Ou abra cada arquivo no MySQL Workbench / DBeaver e execute sequencialmente.

---

## Parte 1 — Modelagem

Oito entidades foram identificadas:

| Entidade | Descrição |
|---|---|
| `hospedes` | Dados cadastrais dos clientes do hotel |
| `quartos` | Unidades habitacionais com tipo, capacidade e preço |
| `funcionarios` | Colaboradores responsáveis pelos atendimentos |
| `reservas` | Intenção de hospedagem (antes do check-in) |
| `hospedagens` | Ocupação efetiva após o check-in |
| `pagamentos` | Transações financeiras vinculadas às hospedagens |
| `servicos` | Catálogo de serviços extras (café, spa, transporte…) |
| `hospedagem_servicos` | Associação N:N entre hospedagens e serviços |
| `avaliacoes` | Notas e comentários pós-estadia |

O diagrama ER completo está em [`parte1/diagrama_er.md`](parte1/diagrama_er.md) (formato Mermaid — visualize em [mermaid.live](https://mermaid.live)).

---

## Parte 2 — Implementação

O banco contém **9 tabelas** com:
- Chaves primárias auto-incrementais em todas as tabelas
- Chaves estrangeiras com integridade referencial
- Restrições `CHECK` para campos como `nota`, `status`, `capacidade` e `preco`
- Índices `UNIQUE` em campos como `email`, `cpf`, `numero` do quarto e `id_reserva` em hospedagens

Os dados de teste incluem:
- 10 hóspedes (brasileiros e estrangeiros)
- 10 quartos (Solteiro, Duplo, Suite, Luxo)
- 9 funcionários (recepcionistas, gerente, camareiros, manutenção)
- 10 serviços (alimentação, lazer, limpeza, transporte)
- 16 reservas (concluídas, canceladas e confirmadas)
- 10 hospedagens com pagamentos e avaliações

---

## Parte 3 — Consultas de Gestão

O arquivo [`parte3/consultas.sql`](parte3/consultas.sql) contém 11 consultas:

| # | Pergunta respondida |
|---|---|
| 1 | Quais quartos estão disponíveis em um período? |
| 2 | Quais hóspedes mais realizaram reservas? |
| 3 | Qual foi o faturamento por mês? |
| 4 | Quais serviços extras são mais consumidos? |
| 5 | Quais quartos receberam melhores avaliações? |
| 6 | Quais reservas foram canceladas? |
| 7 | Quantas hospedagens cada funcionário atendeu? |
| 8 | Receita total por tipo de quarto |
| 9 | Hóspedes sem avaliação registrada |
| 10 | Tempo médio de estadia por tipo de quarto |
| 11 | Resumo financeiro por forma de pagamento |

---

## Modelo lógico (resumo)

```
hospedes        (id_hospede PK, nome, email UNIQUE, cpf UNIQUE, ...)
quartos         (id_quarto PK, numero UNIQUE, tipo, capacidade, preco_diaria, status, ...)
funcionarios    (id_funcionario PK, nome, cargo, email UNIQUE, turno, ativo, ...)
reservas        (id_reserva PK, id_hospede FK, id_quarto FK, data_checkin, data_checkout, status, ...)
hospedagens     (id_hospedagem PK, id_reserva FK UNIQUE, id_funcionario FK, checkin_real, checkout_real, ...)
pagamentos      (id_pagamento PK, id_hospedagem FK, valor, metodo, status, ...)
servicos        (id_servico PK, nome, categoria, preco, ...)
hospedagem_serv (id_hosp_servico PK, id_hospedagem FK, id_servico FK, quantidade, ...)
avaliacoes      (id_avaliacao PK, id_hospede FK, id_quarto FK, id_hospedagem FK UNIQUE, nota, ...)
```
