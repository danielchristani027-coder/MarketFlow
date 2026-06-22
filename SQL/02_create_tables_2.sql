-- ============================================================
-- 02_create_tables.sql
-- Criação das tabelas, constraints (PK, FK, UK, CHECK, DEFAULT)
-- Banco: market_flow
-- ============================================================

-- ------------------------------------------------------------
-- categoria
-- ------------------------------------------------------------
CREATE TABLE public.categoria (
    id_categoria SERIAL      NOT NULL,
    nome         VARCHAR(50) NOT NULL,
    CONSTRAINT categoria_pkey
        PRIMARY KEY (id_categoria)
);

COMMENT ON COLUMN categoria.nome IS 'nome da categoria do produto';

-- ------------------------------------------------------------
-- cliente
-- ------------------------------------------------------------
CREATE TABLE public.cliente (
    id_cliente SERIAL       NOT NULL,
    nome       VARCHAR(150) NOT NULL,
    telefone   VARCHAR(20)  NOT NULL,
    cpf        VARCHAR(14)  NOT NULL UNIQUE,
    endereco   VARCHAR(80)  NOT NULL,
    cidade     VARCHAR(40)  NOT NULL,
    estado     VARCHAR(50)  NOT NULL,
    email      VARCHAR(50),
    CONSTRAINT cliente_pkey
        PRIMARY KEY (id_cliente)
);

COMMENT ON COLUMN cliente.nome     IS 'nome do cliente';
COMMENT ON COLUMN cliente.telefone IS 'telefone do cliente para um possivel contato';
COMMENT ON COLUMN cliente.cpf      IS 'cpf dp cliente';
COMMENT ON COLUMN cliente.endereco IS 'endereço do cliente';
COMMENT ON COLUMN cliente.cidade   IS 'cidade onde se localiza o cliente';

-- ------------------------------------------------------------
-- compra
-- ------------------------------------------------------------
CREATE TABLE public.compra (
    id_compra               SERIAL NOT NULL,
    data_compra             DATE   NOT NULL,
    fornecedorid_fornecedor INT4   NOT NULL,
    CONSTRAINT compra_pkey
        PRIMARY KEY (id_compra)
);

COMMENT ON COLUMN compra.data_compra IS 'data da compra do produto';

-- ------------------------------------------------------------
-- estoque
-- ------------------------------------------------------------
CREATE TABLE public.estoque (
    id_estoque     SERIAL         NOT NULL,
    quantidade     NUMERIC(10, 3),
    estoque_minimo INT4           NOT NULL,
    produto_id     INT4           NOT NULL,
    CONSTRAINT estoque_pkey
        PRIMARY KEY (id_estoque)
);

COMMENT ON COLUMN estoque.quantidade     IS 'quantidade no estoque do mercado';
COMMENT ON COLUMN estoque.estoque_minimo IS 'quantidade minima de estoque no mercado';

-- ------------------------------------------------------------
-- fornecedor
-- ------------------------------------------------------------
CREATE TABLE public.fornecedor (
    id_fornecedor SERIAL        NOT NULL,
    nome_fantasia VARCHAR(100)  NOT NULL,
    telefone      VARCHAR(20)   NOT NULL,
    email         VARCHAR(120)  NOT NULL,
    razao_social  VARCHAR(50)   NOT NULL,
    cnpj          VARCHAR(14)   NOT NULL UNIQUE,
    endereco      VARCHAR(40)   NOT NULL,
    CONSTRAINT fornecedor_pkey
        PRIMARY KEY (id_fornecedor)
);

COMMENT ON COLUMN fornecedor.nome_fantasia IS 'nome do fornecedor';
COMMENT ON COLUMN fornecedor.telefone      IS 'telefone do fornecedor';
COMMENT ON COLUMN fornecedor.email         IS 'email do fornecedor para contato';

-- ------------------------------------------------------------
-- funcionario
-- ------------------------------------------------------------
CREATE TABLE public.funcionario (
    nome_funcionario VARCHAR(150) NOT NULL,
    cargo            VARCHAR(50)  NOT NULL,
    senha            VARCHAR(50)  NOT NULL,
    cpf              VARCHAR(14)  NOT NULL UNIQUE,
    telefone         VARCHAR(11)  NOT NULL,
    login            VARCHAR(20)  NOT NULL,
    id_funcionario   VARCHAR(10)  NOT NULL,
    CONSTRAINT funcionario_pkey
        PRIMARY KEY (id_funcionario)
);

COMMENT ON COLUMN funcionario.nome_funcionario IS 'nome do funcionario';

-- ------------------------------------------------------------
-- item_compra
-- ------------------------------------------------------------
CREATE TABLE public.item_compra (
    quatidade_compra          INT4           NOT NULL,
    preco_compra              NUMERIC(10, 2) NOT NULL,
    compraid_compra           INT4           NOT NULL,
    produto_Pkeyid_prodroduto INT4           NOT NULL,
    id_item_compra            VARCHAR(10)    NOT NULL,
    CONSTRAINT item_compra_pkey
        PRIMARY KEY (id_item_compra)
);

COMMENT ON COLUMN item_compra.quatidade_compra IS 'quatidade de um derteminado produto';
COMMENT ON COLUMN item_compra.preco_compra     IS 'valor do produto';

-- ------------------------------------------------------------
-- item_venda
-- ------------------------------------------------------------
CREATE TABLE public.item_venda (
    quantidade                INT4           NOT NULL,
    preco_unitario            NUMERIC(10, 2) NOT NULL,
    desconto                  NUMERIC(10, 2),
    vendaid_venda             INT4           NOT NULL,
    produto_Pkeyid_prodroduto INT4           NOT NULL,
    id_item_venda             VARCHAR(10)    NOT NULL,
    CONSTRAINT item_venda_pkey
        PRIMARY KEY (id_item_venda)
);

-- ------------------------------------------------------------
-- pagamento
-- ------------------------------------------------------------
CREATE TABLE public.pagamento (
    id_pagamento  SERIAL         NOT NULL,
    tipo          CHAR(15)       NOT NULL CHECK(tipo IN ('Pix','Débito','Crédito','Dinheiro')),
    valor         NUMERIC(10, 2) NOT NULL,
    vendaid_venda INT4           NOT NULL,
    CONSTRAINT pagamento_pkey
        PRIMARY KEY (id_pagamento)
);

COMMENT ON COLUMN pagamento.tipo  IS 'qual seria o tipo de pagamento escolido';
COMMENT ON COLUMN pagamento.valor IS 'qual seria o valor do pagamento';

-- ------------------------------------------------------------
-- produto
-- ------------------------------------------------------------
CREATE TABLE public.produto (
    id_produto        SERIAL         NOT NULL,
    nome_produto      VARCHAR(150),
    descricao_produto VARCHAR(255)   NOT NULL,
    preco_compra      NUMERIC(10, 2) NOT NULL,
    preco_venda       NUMERIC(10, 2) NOT NULL,
    codigo_barras     VARCHAR(50)    NOT NULL UNIQUE,
    validade          DATE           NOT NULL,
    categoria_id      INT4           NOT NULL,
    CONSTRAINT prodro_pkey
        PRIMARY KEY (id_produto)
);

COMMENT ON COLUMN produto.id_produto        IS 'id do produto do mercado';
COMMENT ON COLUMN produto.nome_produto      IS 'nome do produto do mercado';
COMMENT ON COLUMN produto.descricao_produto IS 'uma breve descrição do produto';
COMMENT ON COLUMN produto.preco_venda       IS 'valor do produto';
COMMENT ON COLUMN produto.validade          IS 'validade dos produto do mercado';

-- ------------------------------------------------------------
-- venda
-- ------------------------------------------------------------
CREATE TABLE public.venda (
    id_venda                  SERIAL         NOT NULL,
    data_venda                DATE           NOT NULL,
    valor_total               NUMERIC(10, 2) NOT NULL,
    clienteid_cliente         INT4           NOT NULL,
    funcionarioid_funcionario VARCHAR(10)    NOT NULL,
    CONSTRAINT venda_pkey
        PRIMARY KEY (id_venda)
);

COMMENT ON COLUMN venda.valor_total IS 'valor da venda';

-- ============================================================
-- FOREIGN KEYS
-- ============================================================

ALTER TABLE pagamento   ADD CONSTRAINT FKpagamento663743  FOREIGN KEY (vendaid_venda)                 REFERENCES venda      (id_venda);
ALTER TABLE item_venda  ADD CONSTRAINT FKitem_venda253320 FOREIGN KEY (produto_Pkeyid_prodroduto)     REFERENCES produto    (id_produto);
ALTER TABLE item_venda  ADD CONSTRAINT FKitem_venda212570 FOREIGN KEY (vendaid_venda)                 REFERENCES venda      (id_venda);
ALTER TABLE venda       ADD CONSTRAINT FKvenda467643      FOREIGN KEY (funcionarioid_funcionario)     REFERENCES funcionario(id_funcionario);
ALTER TABLE venda       ADD CONSTRAINT FKvenda865523      FOREIGN KEY (clienteid_cliente)             REFERENCES cliente    (id_cliente);
ALTER TABLE item_compra ADD CONSTRAINT FKitem_compr504514 FOREIGN KEY (produto_Pkeyid_prodroduto)     REFERENCES produto    (id_produto);
ALTER TABLE item_compra ADD CONSTRAINT FKitem_compr545823 FOREIGN KEY (compraid_compra)               REFERENCES compra     (id_compra);
ALTER TABLE compra      ADD CONSTRAINT FKcompra214800     FOREIGN KEY (fornecedorid_fornecedor)       REFERENCES fornecedor (id_fornecedor);
ALTER TABLE produto     ADD CONSTRAINT FKproduto557825    FOREIGN KEY (categoria_id)                  REFERENCES categoria  (id_categoria);
ALTER TABLE estoque     ADD CONSTRAINT FKestoque542128    FOREIGN KEY (produto_id)                    REFERENCES produto    (id_produto);
