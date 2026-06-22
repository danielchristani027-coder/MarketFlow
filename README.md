# Sistema de Gerenciamento de Supermercados - MarketFlow

> Trabalho Final A1 — Banco de Dados I | Ciencia da Computacao | UNOESC Sao Miguel do Oeste — 2026/01 <br/>
> Professor: Roberson Junior Fernandes Alves

---

## Resumo

O MarketFlow é um sistema fictício de gerenciamento para supermercados, desenvolvido como trabalho da disciplina de Banco de Dados I. O projeto tem como objetivo modelar e implementar um banco de dados relacional capaz de atender às principais operações administrativas, comerciais e financeiras de um super mercado.

A modelagem do banco de dados foi desenvolvida seguindo os princípios de normalização até a Terceira Forma Normal (3FN), garantindo a integridade referencial, a redução de redundâncias e a consistência das informações armazenadas. Dessa forma, o sistema oferece uma estrutura robusta e eficiente para apoiar a gestão operacional e estratégica de supermercados.

---
## Requisitos Funcionais

| ID   | Descrição                                                                                               |
| ---- | ------------------------------------------------------------------------------------------------------- |
| RF01 | O sistema deve permitir o cadastro de produtos com nome, código de barras, categoria, preço e validade. |
| RF02 | O sistema deve permitir a atualização dos dados de produtos cadastrados.                                |
| RF03 | O sistema deve permitir a exclusão de produtos.                                                         |
| RF04 | O sistema deve permitir a consulta de produtos por nome, código de barras ou categoria.                 |
| RF05 | O sistema deve controlar a quantidade em estoque de cada produto.                                       |
| RF06 | O sistema deve permitir definir e atualizar o preço de venda dos produtos.                              |
| RF07 | O sistema deve permitir registrar o código de barras dos produtos.                                      |
| RF08 | O sistema deve permitir definir categorias para os produtos.                                            |
| RF09 | O sistema deve controlar a data de validade dos produtos.                                               |
| RF10 | O sistema deve permitir o cadastro de fornecedores com dados de identificação e contato.                |
| RF11 | O sistema deve permitir consultar fornecedores cadastrados.                                             |
| RF12 | O sistema deve permitir atualizar os dados dos fornecedores.                                            |
| RF13 | O sistema deve registrar compras realizadas junto aos fornecedores.                                     |
| RF14 | O sistema deve permitir o cadastro de clientes.                                                         |
| RF15 | O sistema deve permitir consultar o histórico de compras dos clientes.                                  |
| RF16 | O sistema deve permitir cadastrar programas de fidelidade.                                              |
| RF17 | O sistema deve permitir acumular pontos de fidelidade para os clientes.                                 |
| RF18 | O sistema deve permitir o cadastro de funcionários.                                                     |
| RF19 | O sistema deve permitir definir cargos para os funcionários.                                            |
| RF20 | O sistema deve controlar os níveis de acesso dos funcionários ao sistema.                               |
| RF21 | O sistema deve registrar as vendas realizadas por cada funcionário.                                     |
| RF22 | O sistema deve registrar pedidos de compra aos fornecedores.                                            |
| RF23 | O sistema deve registrar a entrada de mercadorias no estoque.                                           |
| RF24 | O sistema deve atualizar automaticamente o estoque após o registro de entradas de mercadorias.          |
| RF25 | O sistema deve registrar vendas de produtos.                                                            |
| RF26 | O sistema deve emitir cupom fiscal para as vendas realizadas.                                           |
| RF27 | O sistema deve permitir a aplicação de descontos nas vendas.                                            |
| RF28 | O sistema deve registrar a forma de pagamento utilizada em cada venda.                                  |
| RF29 | O sistema deve atualizar automaticamente o estoque após a realização de vendas.                         |
| RF30 | O sistema deve registrar entradas de produtos no estoque.                                               |
| RF31 | O sistema deve registrar saídas de produtos do estoque.                                                 |
| RF32 | O sistema deve permitir consultar o saldo atual do estoque.                                             |
| RF33 | O sistema deve alertar quando um produto atingir o estoque mínimo definido.                             |
| RF34 | O sistema deve registrar perdas de produtos por vencimento, dano ou outros motivos.                     |
| RF35 | O sistema deve gerar relatórios financeiros.                                                            |
| RF36 | O sistema deve emitir relatório dos produtos mais vendidos.                                             |
| RF37 | O sistema deve emitir relatório de vendas por período.                                                  |
| RF38 | O sistema deve emitir relatório de lucro por produto.                                                   |
| RF39 | O sistema deve emitir relatório do estoque atual.                                                       |
| RF40 | O sistema deve emitir relatório de produtos próximos ao vencimento.                                     |

## Requisitos Nao Funcionais

| ID    | Descrição                                                                                                   |
| ----- | ----------------------------------------------------------------------------------------------------------- |
| RNF01 | O banco de dados deve ser implementado em PostgreSQL versão 14 ou superior.                                 |
| RNF02 | O modelo de dados deve estar normalizado até a 3ª Forma Normal (3FN).                                       |
| RNF03 | Todos os campos obrigatórios devem utilizar restrição `NOT NULL`.                                           |
| RNF04 | Os códigos de barras devem ser únicos no sistema e protegidos por restrição `UNIQUE`.                       |
| RNF05 | Valores monetários devem utilizar o tipo `NUMERIC(10,2)` para garantir precisão decimal.                    |
| RNF06 | Quantidades em estoque não podem assumir valores negativos.                                                 |
| RNF07 | Datas de validade devem ser posteriores à data de fabricação quando informadas.                             |
| RNF08 | Exclusões de registros pai não devem ser permitidas quando houver registros filhos vinculados (`RESTRICT`). |
| RNF09 | O sistema deve registrar logs das operações de venda, compra e movimentação de estoque.                     |
| RNF10 | Consultas de produtos por código de barras devem ser otimizadas por índices.                                |
| RNF11 | Consultas de vendas por período devem ser suportadas por índices para garantir desempenho.                  |
| RNF12 | O sistema deve possuir autenticação de usuários por login e senha.                                          |
| RNF13 | As senhas dos usuários devem ser armazenadas de forma criptografada.                                        |
| RNF14 | O sistema deve garantir integridade transacional nas operações de venda e atualização de estoque.           |
| RNF15 | O sistema deve estar disponível para uso durante todo o horário de funcionamento do estabelecimento.        |
| RNF16 | O tempo de resposta para consultas comuns não deve exceder 3 segundos.                                      |
| RNF17 | O sistema deve realizar backup periódico dos dados.                                                         |
| RNF18 | O sistema deve preservar o preço do produto no momento da venda para manter o histórico financeiro.         |
| RNF19 | O sistema deve permitir acesso simultâneo de múltiplos usuários sem inconsistência de dados.                |
| RNF20 | O sistema deve seguir as boas práticas de segurança e proteção de dados dos clientes e funcionários.        |
---
## Modelo Relacional
<img width="1167" height="733" alt="Image" src="https://github.com/user-attachments/assets/6e29d633-a463-47c9-93fa-74e44f6e36da" />

---

## Estrutura do repositório

```
bd-market-flow/
├── docs/
│   ├── diagrama-relacional.md   # Modelo lógico com cardinalidades e normalização
│   └── dicionario-de-dados.md   # Dicionário de dados completo (11 tabelas)
└── sql/
    ├── 01_create_database.sql   # Criação do banco de dados
    ├── 02_create_tables.sql     # Tabelas e constraints (PK, FK, UK, CHECK, DEFAULT)
    ├── 03_indexes.sql           # Índices para otimização de consultas
    ├── 04_dados_exemplo.sql     # Dados de exemplo para testes
    └── 05_consultas.sql         # 4 relatórios gerenciais
```

---

## Como executar

**Pré-requisito:** PostgreSQL 14 ou superior instalado.

```bash
# 1. Cria o banco de dados
psql -U postgres -f sql/01_create_database.sql

# 2. Cria as tabelas e constraints
psql -U postgres -d market_flow -f sql/02_create_tables.sql

# 3. Cria os índices
psql -U postgres -d market_flow -f sql/03_indexes.sql

# 4. Insere dados de exemplo (opcional)
psql -U postgres -d market_flow -f sql/04_dados_exemplo.sql

# 5. Executa os relatórios
psql -U postgres -d market_flow -f sql/05_consultas.sql
```

---

## Modelo de dados

O banco conta com **11 tabelas** organizadas em três domínios principais:

**Cadastros base**
- `categoria` — categorias dos produtos
- `fornecedor` — fornecedores de mercadoria
- `cliente` — clientes do mercado
- `funcionario` — funcionários (Caixa, Gerente, Estoquista)

**Estoque e compras**
- `produto` — produtos com preço e validade
- `estoque` — quantidade atual e mínimo por produto
- `compra` — ordens de compra por fornecedor
- `item_compra` — itens de cada ordem de compra

**Vendas e pagamentos**
- `venda` — cabeçalho de cada venda realizada
- `item_venda` — produtos e quantidades de cada venda
- `pagamento` — forma e valor de pagamento (Pix, Débito, Crédito, Dinheiro)

---

## Relatórios disponíveis

| # | Técnica           | Descrição                                                                 |
|---|-------------------|---------------------------------------------------------------------------|
| 1 | ORDER BY / WHERE  | Produtos próximos do vencimento (< 30 dias) com estoque disponível        |
| 2 | JOIN              | Vendas do mês atual acima de R$ 100,00 com dados do funcionário           |
| 3 | JOIN múltiplo     | Produtos em estoque com categoria, fornecedor e preços                    |
| 4 | Sumarização       | Desempenho por funcionário: total de vendas, faturamento e ticket médio   |
## Tecnologias utilizadas

| Tecnologia | Finalidade |
|------------|------------|
| PostgreSQL 14+ | Sistema Gerenciador de Banco de Dados (SGBD) |
| VisualParadigm | Modelagem dos diagramas do banco de dados, incluindo Diagrama Entidade-Relacionamento (DER) e modelo lógico.
| SQL (DDL / DML) | Criacao do esquema, constraints, indices e consultas |
| Git / GitHub | Versionamento e entrega do projeto |

---

## Devs

<table>
  <tr>
    <td align="center">
      <img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/2086a702-533b-42a1-a3c3-7efef403f3a6"><br/>    
      <strong>Arthur Rosanelli</strong><br/>
      Matricula: 449641
    </td>
    <td align="center">
      <img width="115" height="150" alt="Image" src="https://github.com/user-attachments/assets/5ec5ab7f-62c0-4772-9302-7bd2e125d404"><br/>
      <strong>Daniel Christani</strong><br/>
      Matricula: 449472
    </td>
    <td align="center">
      <img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/5f99287d-2794-4402-9bb7-27542bf81f74"><br/>
      <strong>Diogo Rodrigo Nielsson</strong><br/>
      Matricula: 446061
    </td>
    <td align="center">
      <img width="150" height="150" alt="Image" src="https://github.com/user-attachments/assets/ea4454cd-13b3-4d06-a72a-069581005480"><br/>      
      <strong>Felipe Kremer</strong><br/>
      Matricula: 449248
    </td>
  </tr>
</table>

---
