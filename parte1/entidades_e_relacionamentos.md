# Parte 1 — Entidades, Relacionamentos e Regras de Negócio

## 1. Entidades Principais

### HOSPEDES
Representa cada pessoa que se cadastra no sistema para realizar reservas.

| Atributo        | Descrição                                      |
|-----------------|------------------------------------------------|
| id_hospede      | Identificador único do hóspede                 |
| nome            | Nome completo                                  |
| email           | E-mail de contato (único no sistema)           |
| cpf             | CPF do hóspede (único, opcional p/ estrangeiros)|
| telefone        | Número de telefone                             |
| data_nascimento | Data de nascimento                             |
| nacionalidade   | País de origem                                 |
| endereco        | Endereço residencial                           |
| criado_em       | Data e hora do cadastro                        |

---

### QUARTOS
Representa cada unidade habitacional disponível no hotel.

| Atributo     | Descrição                                         |
|--------------|---------------------------------------------------|
| id_quarto    | Identificador único do quarto                     |
| numero       | Número ou código do quarto (ex: "101", "2A")      |
| tipo         | Categoria: Solteiro, Duplo, Suite, Luxo           |
| capacidade   | Número máximo de hóspedes                         |
| preco_diaria | Valor cobrado por diária                          |
| status       | Situação atual: disponível, ocupado, manutenção   |
| andar        | Andar do hotel onde o quarto está localizado      |
| descricao    | Descrição de comodidades e características        |

---

### RESERVAS
Registra a intenção de um hóspede de ocupar um quarto em um período.

| Atributo      | Descrição                                          |
|---------------|----------------------------------------------------|
| id_reserva    | Identificador único da reserva                     |
| id_hospede    | Referência ao hóspede que realizou a reserva       |
| id_quarto     | Referência ao quarto reservado                     |
| data_checkin  | Data prevista de entrada                           |
| data_checkout | Data prevista de saída                             |
| status        | Situação: confirmada, cancelada, pendente, concluída|
| num_hospedes  | Quantidade de pessoas que vão se hospedar          |
| criado_em     | Data e hora em que a reserva foi criada            |

---

### HOSPEDAGENS
Registra a ocupação real do quarto (confirmação efetiva de que o hóspede chegou).

| Atributo       | Descrição                                         |
|----------------|---------------------------------------------------|
| id_hospedagem  | Identificador único da hospedagem                 |
| id_reserva     | Referência à reserva que originou a hospedagem    |
| id_funcionario | Funcionário que realizou o check-in               |
| checkin_real   | Data e hora efetiva de entrada                    |
| checkout_real  | Data e hora efetiva de saída                      |
| observacoes    | Notas ou ocorrências durante a estadia            |

---

### PAGAMENTOS
Registra cada transação financeira vinculada a uma hospedagem.

| Atributo       | Descrição                                         |
|----------------|---------------------------------------------------|
| id_pagamento   | Identificador único do pagamento                  |
| id_hospedagem  | Referência à hospedagem paga                      |
| valor          | Valor cobrado                                     |
| metodo         | Forma de pagamento: cartão, Pix, dinheiro, etc.   |
| status         | Situação: pago, pendente, estornado               |
| data_pagamento | Data e hora da transação                          |

---

### FUNCIONARIOS
Representa os colaboradores do hotel que interagem com o sistema.

| Atributo       | Descrição                                         |
|----------------|---------------------------------------------------|
| id_funcionario | Identificador único do funcionário                |
| nome           | Nome completo                                     |
| cargo          | Função: recepcionista, gerente, camareira, etc.   |
| email          | E-mail corporativo                                |
| telefone       | Contato                                           |
| turno          | Turno de trabalho: manhã, tarde, noite            |
| data_admissao  | Data de início no hotel                           |
| ativo          | Indica se o funcionário ainda está ativo          |

---

### SERVICOS
Catálogo de serviços extras disponíveis para hóspedes durante a estadia.

| Atributo   | Descrição                                           |
|------------|-----------------------------------------------------|
| id_servico | Identificador único do serviço                      |
| nome       | Nome do serviço (ex: "Café da manhã", "Lavanderia") |
| categoria  | Grupo: alimentação, lazer, limpeza, transporte      |
| preco      | Valor cobrado por unidade                           |
| descricao  | Detalhes sobre o serviço                            |

---

### HOSPEDAGEM_SERVICOS *(tabela associativa)*
Vincula serviços solicitados a uma hospedagem específica.

| Atributo        | Descrição                                      |
|-----------------|------------------------------------------------|
| id_hosp_servico | Identificador da associação                    |
| id_hospedagem   | Referência à hospedagem                        |
| id_servico      | Referência ao serviço solicitado               |
| quantidade      | Quantidade solicitada do serviço               |
| solicitado_em   | Data e hora da solicitação                     |

---

### AVALIACOES
Registra a avaliação e comentário do hóspede após a estadia.

| Atributo       | Descrição                                         |
|----------------|---------------------------------------------------|
| id_avaliacao   | Identificador único da avaliação                  |
| id_hospede     | Hóspede que avaliou                               |
| id_quarto      | Quarto avaliado                                   |
| id_hospedagem  | Hospedagem que originou a avaliação               |
| nota           | Nota de 1 a 5                                     |
| comentario     | Texto livre de feedback                           |
| data_avaliacao | Data e hora do registro                           |

---

## 2. Relacionamentos

| Relacionamento                           | Cardinalidade | Descrição                                                       |
|------------------------------------------|---------------|-----------------------------------------------------------------|
| HOSPEDES → RESERVAS                      | 1 : N         | Um hóspede pode fazer várias reservas                           |
| QUARTOS → RESERVAS                       | 1 : N         | Um quarto pode aparecer em várias reservas (em períodos diferentes) |
| RESERVAS → HOSPEDAGENS                   | 1 : 1         | Cada reserva confirmada gera exatamente uma hospedagem          |
| HOSPEDAGENS → PAGAMENTOS                 | 1 : N         | Uma hospedagem pode ter múltiplos pagamentos (parcelas, extras)  |
| FUNCIONARIOS → HOSPEDAGENS               | 1 : N         | Um funcionário pode atender vários check-ins                    |
| HOSPEDAGENS → HOSPEDAGEM_SERVICOS        | 1 : N         | Uma hospedagem pode solicitar vários serviços                   |
| SERVICOS → HOSPEDAGEM_SERVICOS           | 1 : N         | Um serviço pode ser solicitado em várias hospedagens            |
| HOSPEDES → AVALIACOES                    | 1 : N         | Um hóspede pode avaliar várias estadias                         |
| QUARTOS → AVALIACOES                     | 1 : N         | Um quarto pode receber várias avaliações                        |
| HOSPEDAGENS → AVALIACOES                 | 1 : 1         | Cada hospedagem pode originar no máximo uma avaliação           |

---

## 3. Regras de Negócio

1. **Datas de reserva**: `data_checkout` deve ser sempre posterior a `data_checkin`.
2. **Disponibilidade**: Um quarto com `status = 'ocupado'` não pode receber nova reserva para o mesmo período.
3. **Capacidade**: O campo `num_hospedes` em RESERVAS não pode superar a `capacidade` do quarto.
4. **Hospedagem única por reserva**: Cada reserva gera no máximo uma hospedagem.
5. **Pagamento vinculado**: Pagamentos só existem vinculados a uma hospedagem existente.
6. **Avaliação pós-estadia**: Uma avaliação só pode ser registrada após o `checkout_real` ser preenchido.
7. **Nota válida**: A nota em AVALIACOES deve ser um inteiro entre 1 e 5.
8. **Serviços com quantidade**: A quantidade em HOSPEDAGEM_SERVICOS deve ser maior que zero.
9. **Hóspede único**: Email e CPF do hóspede devem ser únicos no sistema.
10. **Funcionário ativo**: Apenas funcionários com `ativo = true` podem ser associados a novas hospedagens.

---

## 4. Modelo Lógico Relacional

```
hospedes (id_hospede PK, nome, email UNIQUE, cpf UNIQUE, telefone, data_nascimento, nacionalidade, endereco, criado_em)

quartos (id_quarto PK, numero UNIQUE, tipo, capacidade, preco_diaria, status, andar, descricao)

reservas (id_reserva PK, id_hospede FK→hospedes, id_quarto FK→quartos, data_checkin, data_checkout, status, num_hospedes, criado_em)

hospedagens (id_hospedagem PK, id_reserva FK→reservas UNIQUE, id_funcionario FK→funcionarios, checkin_real, checkout_real, observacoes)

pagamentos (id_pagamento PK, id_hospedagem FK→hospedagens, valor, metodo, status, data_pagamento)

funcionarios (id_funcionario PK, nome, cargo, email UNIQUE, telefone, turno, data_admissao, ativo)

servicos (id_servico PK, nome, categoria, preco, descricao)

hospedagem_servicos (id_hosp_servico PK, id_hospedagem FK→hospedagens, id_servico FK→servicos, quantidade, solicitado_em)

avaliacoes (id_avaliacao PK, id_hospede FK→hospedes, id_quarto FK→quartos, id_hospedagem FK→hospedagens UNIQUE, nota CHECK(1-5), comentario, data_avaliacao)
```
