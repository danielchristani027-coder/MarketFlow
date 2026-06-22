# Dicionário de Dados — Market Flow

> Banco de dados: `market_flow` | SGBD: PostgreSQL 14+  
> Total de tabelas: **11**

---

## categoria

| Coluna       | Tipo          | Restrições  | Descrição                        |
|--------------|---------------|-------------|----------------------------------|
| id_categoria | SERIAL        | PK          | Identificador único da categoria |
| nome         | VARCHAR(50)   | NOT NULL    | Nome da categoria do produto     |

---

## fornecedor

| Coluna        | Tipo          | Restrições    | Descrição                           |
|---------------|---------------|---------------|-------------------------------------|
| id_fornecedor | SERIAL        | PK            | Identificador único do fornecedor   |
| nome_fantasia | VARCHAR(100)  | NOT NULL      | Nome comercial do fornecedor        |
| telefone      | VARCHAR(20)   | NOT NULL      | Telefone de contato                 |
| email         | VARCHAR(120)  | NOT NULL      | E-mail de contato                   |
| razao_social  | VARCHAR(50)   | NOT NULL      | Razão social                        |
| cnpj          | VARCHAR(14)   | NOT NULL, UK  | CNPJ (único)                        |
| endereco      | VARCHAR(40)   | NOT NULL      | Endereço da empresa                 |

---

## cliente

| Coluna     | Tipo         | Restrições    | Descrição                        |
|------------|--------------|---------------|----------------------------------|
| id_cliente | SERIAL       | PK            | Identificador único do cliente   |
| nome       | VARCHAR(150) | NOT NULL      | Nome completo                    |
| telefone   | VARCHAR(20)  | NOT NULL      | Telefone de contato              |
| cpf        | VARCHAR(14)  | NOT NULL, UK  | CPF (único)                      |
| endereco   | VARCHAR(80)  | NOT NULL      | Endereço residencial             |
| cidade     | VARCHAR(40)  | NOT NULL      | Cidade do cliente                |
| estado     | VARCHAR(50)  | NOT NULL      | Estado (UF)                      |
| email      | VARCHAR(50)  | —             | E-mail (opcional)                |

---

## funcionario

| Coluna          | Tipo         | Restrições    | Descrição                           |
|-----------------|--------------|---------------|-------------------------------------|
| id_funcionario  | VARCHAR(10)  | PK            | Código do funcionário (ex.: F001)   |
| nome_funcionario| VARCHAR(150) | NOT NULL      | Nome completo                       |
| cargo           | VARCHAR(50)  | NOT NULL      | Cargo (Caixa, Gerente, Estoquista…) |
| senha           | VARCHAR(50)  | NOT NULL      | Senha de acesso ao sistema          |
| cpf             | VARCHAR(14)  | NOT NULL, UK  | CPF (único)                         |
| telefone        | VARCHAR(11)  | NOT NULL      | Telefone de contato                 |
| login           | VARCHAR(20)  | NOT NULL      | Login de acesso ao sistema          |

---

## produto

| Coluna           | Tipo          | Restrições      | Descrição                           |
|------------------|---------------|-----------------|-------------------------------------|
| id_produto       | SERIAL        | PK              | Identificador único do produto      |
| nome_produto     | VARCHAR(150)  | —               | Nome do produto                     |
| descricao_produto| VARCHAR(255)  | NOT NULL        | Descrição resumida                  |
| preco_compra     | NUMERIC(10,2) | NOT NULL, > 0   | Preço de custo                      |
| preco_venda      | NUMERIC(10,2) | NOT NULL, > 0   | Preço de venda ao consumidor        |
| codigo_barras    | VARCHAR(50)   | NOT NULL, UK    | Código de barras (único)            |
| validade         | DATE          | NOT NULL        | Data de validade                    |
| categoria_id     | INT4          | NOT NULL, FK    | Referência à tabela categoria       |

---

## estoque

| Coluna        | Tipo           | Restrições   | Descrição                                |
|---------------|----------------|--------------|------------------------------------------|
| id_estoque    | SERIAL         | PK           | Identificador único do registro          |
| quantidade    | NUMERIC(10,3)  | —            | Quantidade atual em estoque              |
| estoque_minimo| INT4           | NOT NULL     | Quantidade mínima antes do ressuprimento |
| produto_id    | INT4           | NOT NULL, FK | Referência ao produto                    |

---

## compra

| Coluna                  | Tipo  | Restrições   | Descrição                          |
|-------------------------|-------|--------------|------------------------------------|
| id_compra               | SERIAL| PK           | Identificador único da compra      |
| data_compra             | DATE  | NOT NULL     | Data da realização da compra       |
| fornecedorid_fornecedor | INT4  | NOT NULL, FK | Referência ao fornecedor           |

---

## item_compra

| Coluna                   | Tipo          | Restrições   | Descrição                       |
|--------------------------|---------------|--------------|---------------------------------|
| id_item_compra           | VARCHAR(10)   | PK           | Código do item (ex.: IC001)     |
| quatidade_compra         | INT4          | NOT NULL     | Quantidade comprada             |
| preco_compra             | NUMERIC(10,2) | NOT NULL     | Preço unitário de compra        |
| compraid_compra          | INT4          | NOT NULL, FK | Referência à compra             |
| produto_Pkeyid_prodroduto| INT4          | NOT NULL, FK | Referência ao produto           |

---

## venda

| Coluna                   | Tipo          | Restrições      | Descrição                       |
|--------------------------|---------------|-----------------|---------------------------------|
| id_venda                 | SERIAL        | PK              | Identificador único da venda    |
| data_venda               | DATE          | NOT NULL        | Data da venda                   |
| valor_total              | NUMERIC(10,2) | NOT NULL, >= 0  | Valor total da venda            |
| clienteid_cliente        | INT4          | NOT NULL, FK    | Referência ao cliente           |
| funcionarioid_funcionario| VARCHAR(10)   | NOT NULL, FK    | Referência ao funcionário       |

---

## item_venda

| Coluna                   | Tipo          | Restrições   | Descrição                       |
|--------------------------|---------------|--------------|---------------------------------|
| id_item_venda            | VARCHAR(10)   | PK           | Código do item (ex.: IV001)     |
| quantidade               | INT4          | NOT NULL     | Quantidade vendida              |
| preco_unitario           | NUMERIC(10,2) | NOT NULL     | Preço unitário de venda         |
| desconto                 | NUMERIC(10,2) | —            | Desconto aplicado (opcional)    |
| vendaid_venda            | INT4          | NOT NULL, FK | Referência à venda              |
| produto_Pkeyid_prodroduto| INT4          | NOT NULL, FK | Referência ao produto           |

---

## pagamento

| Coluna       | Tipo          | Restrições                              | Descrição                                  |
|--------------|---------------|-----------------------------------------|--------------------------------------------|
| id_pagamento | SERIAL        | PK                                      | Identificador único do pagamento           |
| tipo         | CHAR(15)      | NOT NULL, CHECK IN (Pix/Débito/Crédito/Dinheiro) | Forma de pagamento              |
| valor        | NUMERIC(10,2) | NOT NULL                                | Valor pago                                 |
| vendaid_venda| INT4          | NOT NULL, FK                            | Referência à venda                         |
