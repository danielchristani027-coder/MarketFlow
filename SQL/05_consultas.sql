-- ============================================================
-- 05_consultas.sql
-- 4 relatórios gerenciais
-- Banco: market_flow
-- ============================================================


-- ------------------------------------------------------------
-- Relatório 1 — ORDER BY / WHERE
-- Lista todos os produtos com data de validade inferior a
-- 30 dias a partir da data atual e com estoque maior que zero,
-- apresentando o código, o nome, a categoria, a quantidade em
-- estoque e a data de validade.
-- Ordena pela data de validade crescente e, em caso de empate,
-- pelo nome do produto.
-- ------------------------------------------------------------
SELECT
    p.id_produto       AS codigo,
    p.nome_produto     AS nome,
    c.nome             AS categoria,
    e.quantidade       AS quantidade_em_estoque,
    p.validade         AS data_validade
FROM   produto   p
JOIN   categoria c  ON  c.id_categoria = p.categoria_id
JOIN   estoque   e  ON  e.produto_id   = p.id_produto
WHERE  p.validade  < CURRENT_DATE + INTERVAL '30 days'
  AND  p.validade >= CURRENT_DATE
  AND  e.quantidade > 0
ORDER BY
    p.validade     ASC,
    p.nome_produto ASC;


-- ------------------------------------------------------------
-- Relatório 2 — JOIN
-- Lista as vendas realizadas no mês atual com valor total
-- superior a R$ 100,00, exibindo o número da venda, o nome
-- e o cargo do funcionário responsável, o número do caixa
-- utilizado, a data e o valor total.
-- Ordena pela data da venda do mais recente para o mais antigo.
-- ------------------------------------------------------------
SELECT
    v.id_venda             AS numero_venda,
    f.nome_funcionario     AS nome_funcionario,
    f.cargo                AS cargo_funcionario,
    v.id_venda             AS numero_caixa,
    v.data_venda           AS data_venda,
    v.valor_total          AS valor_total
FROM   venda       v
JOIN   funcionario f
       ON  f.id_funcionario = v.funcionarioid_funcionario
WHERE  v.valor_total > 100.00
  AND  EXTRACT(MONTH FROM v.data_venda) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND  EXTRACT(YEAR  FROM v.data_venda) = EXTRACT(YEAR  FROM CURRENT_DATE)
ORDER BY
    v.data_venda DESC;


-- ------------------------------------------------------------
-- Relatório 3 — JOIN
-- Lista os produtos disponíveis em estoque, exibindo o nome
-- do produto, a categoria, o nome e o telefone do fornecedor,
-- a quantidade em estoque, o preço de custo e o preço de venda.
-- Ordena por categoria e, em seguida, pelo nome do produto.
-- ------------------------------------------------------------
SELECT
    p.nome_produto    AS nome_produto,
    c.nome            AS categoria,
    fo.nome_fantasia  AS nome_fornecedor,
    fo.telefone       AS telefone_fornecedor,
    e.quantidade      AS quantidade_em_estoque,
    p.preco_compra    AS preco_custo,
    p.preco_venda     AS preco_venda
FROM   produto     p
JOIN   categoria   c   ON  c.id_categoria               = p.categoria_id
JOIN   estoque     e   ON  e.produto_id                 = p.id_produto
JOIN   item_compra ic  ON  ic.produto_Pkeyid_prodroduto = p.id_produto
JOIN   compra      co  ON  co.id_compra                 = ic.compraid_compra
JOIN   fornecedor  fo  ON  fo.id_fornecedor             = co.fornecedorid_fornecedor
WHERE  e.quantidade > 0
ORDER BY
    c.nome         ASC,
    p.nome_produto ASC;


-- ------------------------------------------------------------
-- Relatório 4 — Sumarização
-- Para cada funcionário, apresenta o total de vendas no mês
-- atual, o valor total vendido e o ticket médio por venda
-- (valor total ÷ número de vendas).
-- Exibe apenas os funcionários que realizaram mais de 5 vendas
-- no mês.
-- Ordena pelo valor total vendido de forma decrescente.
-- ------------------------------------------------------------
SELECT
    f.nome_funcionario                   AS nome_funcionario,
    COUNT(v.id_venda)                    AS total_vendas,
    SUM(v.valor_total)                   AS valor_total_vendido,
    ROUND(SUM(v.valor_total)
        / COUNT(v.id_venda), 2)          AS ticket_medio
FROM   funcionario f
JOIN   venda       v
       ON  v.funcionarioid_funcionario = f.id_funcionario
WHERE  EXTRACT(MONTH FROM v.data_venda) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND  EXTRACT(YEAR  FROM v.data_venda) = EXTRACT(YEAR  FROM CURRENT_DATE)
GROUP BY
    f.id_funcionario,
    f.nome_funcionario
HAVING COUNT(v.id_venda) > 5
ORDER BY
    valor_total_vendido DESC;
