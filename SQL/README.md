# bd-market-flow

Banco de dados relacional para um sistema de mercado, desenvolvido em **PostgreSQL 14+**.  
Abrange cadastro de produtos, clientes, funcionários, fornecedores, controle de estoque, compras, vendas e pagamentos.

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

---

## Tecnologias

- **PostgreSQL 14+**
- SQL padrão ANSI com extensões PostgreSQL (`SERIAL`, `CURRENT_DATE`, `DATE_TRUNC`, `EXTRACT`)
