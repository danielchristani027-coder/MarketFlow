# Diagrama Relacional — Market Flow

## Modelo Lógico com Cardinalidades e Normalização

### Tabelas e relacionamentos

```
categoria (1) ──────────────────── (N) produto
fornecedor (1) ──────────────────── (N) compra
compra     (1) ──────────────────── (N) item_compra
produto    (1) ──────────────────── (N) item_compra
produto    (1) ──────────────────── (1) estoque
produto    (1) ──────────────────── (N) item_venda
cliente    (1) ──────────────────── (N) venda
funcionario(1) ──────────────────── (N) venda
venda      (1) ──────────────────── (N) item_venda
venda      (1) ──────────────────── (N) pagamento
```

---

### Descrição das tabelas

| Tabela       | Chave Primária   | Chaves Estrangeiras                              |
|--------------|------------------|--------------------------------------------------|
| categoria    | id_categoria     | —                                                |
| fornecedor   | id_fornecedor    | —                                                |
| cliente      | id_cliente       | —                                                |
| funcionario  | id_funcionario   | —                                                |
| produto      | id_produto       | categoria_id → categoria                         |
| estoque      | id_estoque       | produto_id → produto                             |
| compra       | id_compra        | fornecedorid_fornecedor → fornecedor             |
| item_compra  | id_item_compra   | compraid_compra → compra, produto_id → produto   |
| venda        | id_venda         | clienteid_cliente → cliente, funcionarioid → funcionario |
| item_venda   | id_item_venda    | vendaid_venda → venda, produto_id → produto      |
| pagamento    | id_pagamento     | vendaid_venda → venda                            |

---

### Formas Normais

- **1FN** — Todos os atributos são atômicos; sem grupos repetidos.
- **2FN** — Atributos não-chave dependem totalmente da PK em cada tabela.
- **3FN** — Sem dependências transitivas; tabelas de domínio (categoria, fornecedor) isoladas.
