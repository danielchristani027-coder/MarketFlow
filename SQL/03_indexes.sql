-- ============================================================
-- 03_indexes.sql
-- Índices para otimização de consultas
-- Banco: market_flow
-- ============================================================

-- produto: buscas por nome e validade (relatórios de vencimento)
CREATE INDEX idx_produto_nome     ON produto (nome_produto);
CREATE INDEX idx_produto_validade ON produto (validade);
CREATE INDEX idx_produto_categoria ON produto (categoria_id);

-- estoque: buscas por produto
CREATE INDEX idx_estoque_produto  ON estoque (produto_id);

-- cliente: buscas por nome e CPF
CREATE INDEX idx_cliente_nome     ON cliente (nome);
CREATE INDEX idx_cliente_cpf      ON cliente (cpf);

-- funcionario: buscas por cargo e login
CREATE INDEX idx_funcionario_cargo ON funcionario (cargo);
CREATE INDEX idx_funcionario_login ON funcionario (login);

-- venda: buscas por data, cliente e funcionário (relatórios gerenciais)
CREATE INDEX idx_venda_data_venda   ON venda (data_venda);
CREATE INDEX idx_venda_cliente      ON venda (clienteid_cliente);
CREATE INDEX idx_venda_funcionario  ON venda (funcionarioid_funcionario);

-- item_venda: buscas por venda e produto
CREATE INDEX idx_item_venda_venda   ON item_venda (vendaid_venda);
CREATE INDEX idx_item_venda_produto ON item_venda (produto_Pkeyid_prodroduto);

-- compra: buscas por data e fornecedor
CREATE INDEX idx_compra_data        ON compra (data_compra);
CREATE INDEX idx_compra_fornecedor  ON compra (fornecedorid_fornecedor);

-- item_compra: buscas por compra e produto
CREATE INDEX idx_item_compra_compra  ON item_compra (compraid_compra);
CREATE INDEX idx_item_compra_produto ON item_compra (produto_Pkeyid_prodroduto);

-- pagamento: buscas por venda e tipo
CREATE INDEX idx_pagamento_venda ON pagamento (vendaid_venda);
CREATE INDEX idx_pagamento_tipo  ON pagamento (tipo);
