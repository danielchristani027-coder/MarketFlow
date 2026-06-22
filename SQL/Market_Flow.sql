-- ============================================================
-- SCRIPT COMPLETO — Sistema de Mercado (market_flow)
-- Conteúdo: DDL + INSERTs + Relatórios
-- ============================================================

CREATE TABLE public.categoria(
  id_categoria SERIAL NOT NULL, 
  nome         varchar(50) NOT NULL, 
  CONSTRAINT categoria_pkey 
    PRIMARY KEY (id_categoria));
COMMENT ON COLUMN categoria.nome IS 'nome da categoria do produto';

CREATE TABLE public.cliente (
  id_cliente SERIAL NOT NULL, 
  nome       varchar(150) NOT NULL, 
  telefone   varchar(20) NOT NULL, 
  cpf        varchar(14) NOT NULL UNIQUE, 
  endereco   varchar(80) NOT NULL, 
  cidade     varchar(40) NOT NULL, 
  estado     varchar(50) NOT NULL, 
  email      varchar(50), 
  CONSTRAINT cliente_pkey 
    PRIMARY KEY (id_cliente));
COMMENT ON COLUMN cliente.nome IS 'nome do cliente';
COMMENT ON COLUMN cliente.telefone IS 'telefone do cliente para um possivel contato';
COMMENT ON COLUMN cliente.cpf IS 'cpf dp cliente';
COMMENT ON COLUMN cliente.endereco IS 'endereço do cliente';
COMMENT ON COLUMN cliente.cidade IS 'cidade onde se localiza o cliente';

CREATE TABLE public.compra (
  id_compra               SERIAL NOT NULL, 
  data_compra             date NOT NULL, 
  fornecedorid_fornecedor int4 NOT NULL, 
  CONSTRAINT compra_pkey 
    PRIMARY KEY (id_compra));
COMMENT ON COLUMN compra.data_compra IS 'data da compra do produto';

CREATE TABLE public.estoque (
  id_estoque     SERIAL NOT NULL, 
  quantidade     numeric(10, 3), 
  estoque_minimo int4 NOT NULL, 
  produto_id     int4 NOT NULL, 
  CONSTRAINT estoque_pkey 
    PRIMARY KEY (id_estoque));
COMMENT ON COLUMN estoque.quantidade IS 'quantidade no estoque do mercado';
COMMENT ON COLUMN estoque.estoque_minimo IS 'quantidade minima de estoque no mercado';

CREATE TABLE public.fornecedor (
  id_fornecedor SERIAL NOT NULL, 
  nome_fantasia varchar(100) NOT NULL, 
  telefone      varchar(20) NOT NULL, 
  email         varchar(120) NOT NULL, 
  razao_social  varchar(50) NOT NULL, 
  cnpj          varchar(14) NOT NULL UNIQUE, 
  endereco      varchar(40) NOT NULL, 
  CONSTRAINT fornecedor_pkey 
    PRIMARY KEY (id_fornecedor));
COMMENT ON COLUMN fornecedor.nome_fantasia IS 'nome do fornecedor';
COMMENT ON COLUMN fornecedor.telefone IS 'telefone do fornecedor';
COMMENT ON COLUMN fornecedor.email IS 'email do fornecedor para contato';

CREATE TABLE public.funcionario (
  nome_funcionario varchar(150) NOT NULL, 
  cargo            varchar(50) NOT NULL, 
  senha            varchar(50) NOT NULL, 
  cpf              varchar(14) NOT NULL UNIQUE, 
  telefone         varchar(11) NOT NULL, 
  login            varchar(20) NOT NULL, 
  id_funcionario   varchar(10) NOT NULL, 
  CONSTRAINT funcionario_pkey 
    PRIMARY KEY (id_funcionario));
COMMENT ON COLUMN funcionario.nome_funcionario IS 'nome do funcionario';

CREATE TABLE public.item_compra (
  quatidade_compra          int4 NOT NULL, 
  preco_compra              numeric(10, 2) NOT NULL, 
  compraid_compra           int4 NOT NULL, 
  produto_Pkeyid_prodroduto int4 NOT NULL, 
  id_item_compra            varchar(10) NOT NULL, 
  CONSTRAINT item_compra_pkey 
    PRIMARY KEY (id_item_compra));
COMMENT ON COLUMN item_compra.quatidade_compra IS 'quatidade de um derteminado produto';
COMMENT ON COLUMN item_compra.preco_compra IS 'valor do produto';

CREATE TABLE public.item_venda (
  quantidade                int4 NOT NULL, 
  preco_unitario            numeric(10, 2) NOT NULL, 
  desconto                  numeric(10, 2), 
  vendaid_venda             int4 NOT NULL, 
  produto_Pkeyid_prodroduto int4 NOT NULL, 
  id_item_venda             varchar(10) NOT NULL, 
  CONSTRAINT item_venda_pkey 
    PRIMARY KEY (id_item_venda));

CREATE TABLE public.pagamento (
  id_pagamento  SERIAL NOT NULL, 
  tipo          char(15) NOT NULL CHECK(tipo in ('Pix','Débito','Crédito','Dinheiro')), 
  valor         numeric(10, 2) NOT NULL, 
  vendaid_venda int4 NOT NULL, 
  CONSTRAINT pagamento_pkey 
    PRIMARY KEY (id_pagamento));
COMMENT ON COLUMN pagamento.tipo IS 'qual seria o tipo de pagamento escolido';
COMMENT ON COLUMN pagamento.valor IS 'qual seria o valor do pagamento';

CREATE TABLE public.produto (
  id_produto        SERIAL NOT NULL, 
  nome_produto      varchar(150), 
  descricao_produto varchar(255) NOT NULL, 
  preco_compra      numeric(10, 2) NOT NULL, 
  preco_venda       numeric(10, 2) NOT NULL, 
  codigo_barras     varchar(50) NOT NULL UNIQUE, 
  validade          date NOT NULL, 
  categoria_id      int4 NOT NULL, 
  CONSTRAINT prodro_pkey 
    PRIMARY KEY (id_produto));
COMMENT ON COLUMN produto.id_produto IS 'id do produto do mercado';
COMMENT ON COLUMN produto.nome_produto IS 'nome do produto do mercado';
COMMENT ON COLUMN produto.descricao_produto IS 'uma breve descrição do produto';
COMMENT ON COLUMN produto.preco_venda IS 'valor do produto';
COMMENT ON COLUMN produto.validade IS 'validade dos produto do mercado';

CREATE TABLE public.venda (
  id_venda                  SERIAL NOT NULL, 
  data_venda                date NOT NULL, 
  valor_total               numeric(10, 2) NOT NULL, 
  clienteid_cliente         int4 NOT NULL, 
  funcionarioid_funcionario varchar(10) NOT NULL, 
  CONSTRAINT venda_pkey 
    PRIMARY KEY (id_venda));
COMMENT ON COLUMN venda.valor_total IS 'valor da venda';

ALTER TABLE pagamento ADD CONSTRAINT FKpagamento663743 FOREIGN KEY (vendaid_venda) REFERENCES venda (id_venda);
ALTER TABLE item_venda ADD CONSTRAINT FKitem_venda253320 FOREIGN KEY (produto_Pkeyid_prodroduto) REFERENCES produto (id_produto);
ALTER TABLE item_venda ADD CONSTRAINT FKitem_venda212570 FOREIGN KEY (vendaid_venda) REFERENCES venda (id_venda);
ALTER TABLE venda ADD CONSTRAINT FKvenda467643 FOREIGN KEY (funcionarioid_funcionario) REFERENCES funcionario (id_funcionario);
ALTER TABLE venda ADD CONSTRAINT FKvenda865523 FOREIGN KEY (clienteid_cliente) REFERENCES cliente (id_cliente);
ALTER TABLE item_compra ADD CONSTRAINT FKitem_compr504514 FOREIGN KEY (produto_Pkeyid_prodroduto) REFERENCES produto (id_produto);
ALTER TABLE item_compra ADD CONSTRAINT FKitem_compr545823 FOREIGN KEY (compraid_compra) REFERENCES compra (id_compra);
ALTER TABLE compra ADD CONSTRAINT FKcompra214800 FOREIGN KEY (fornecedorid_fornecedor) REFERENCES fornecedor (id_fornecedor);
ALTER TABLE produto ADD CONSTRAINT FKproduto557825 FOREIGN KEY (categoria_id) REFERENCES categoria (id_categoria);
ALTER TABLE estoque ADD CONSTRAINT FKestoque542128 FOREIGN KEY (produto_id) REFERENCES produto (id_produto);


-- ============================================================
-- INSERTS
-- ============================================================

-- ------------------------------------------------------------
-- categoria
-- ------------------------------------------------------------
INSERT INTO categoria (nome) VALUES
  ('Laticínios'),
  ('Bebidas'),
  ('Hortifruti'),
  ('Padaria'),
  ('Limpeza'),
  ('Higiene Pessoal'),
  ('Carnes'),
  ('Congelados'),
  ('Mercearia'),
  ('Frios');

-- ------------------------------------------------------------
-- cliente
-- ------------------------------------------------------------
INSERT INTO cliente (nome, telefone, cpf, endereco, cidade, estado, email) VALUES
  ('Ana Paula Souza',      '11987654321', '123.456.789-00', 'Rua das Flores, 10',    'São Paulo',   'SP', 'ana.paula@email.com'),
  ('Carlos Eduardo Lima',  '11976543210', '234.567.890-11', 'Av. Brasil, 200',       'São Paulo',   'SP', 'carlos.lima@email.com'),
  ('Fernanda Oliveira',    '11965432109', '345.678.901-22', 'Rua XV de Novembro, 5', 'Campinas',    'SP', 'fernanda.o@email.com'),
  ('Roberto Alves',        '11954321098', '456.789.012-33', 'Rua Augusta, 300',      'São Paulo',   'SP', NULL),
  ('Juliana Costa',        '11943210987', '567.890.123-44', 'Rua da Paz, 88',        'Santo André', 'SP', 'ju.costa@email.com'),
  ('Marcos Pereira',       '11932109876', '678.901.234-55', 'Av. Paulista, 1500',    'São Paulo',   'SP', 'marcos.p@email.com'),
  ('Patrícia Santos',      '11921098765', '789.012.345-66', 'Rua 7 de Setembro, 45', 'Guarulhos',   'SP', NULL),
  ('Diego Ferreira',       '11910987654', '890.123.456-77', 'Alameda Santos, 900',   'São Paulo',   'SP', 'diego.f@email.com'),
  ('Luciana Mendes',       '11909876543', '901.234.567-88', 'Rua Consolação, 77',    'São Paulo',   'SP', 'lu.mendes@email.com'),
  ('Thiago Rodrigues',     '11998877665', '012.345.678-99', 'Rua Vergueiro, 210',    'São Paulo',   'SP', 'thiago.r@email.com');

-- ------------------------------------------------------------
-- fornecedor
-- ------------------------------------------------------------
INSERT INTO fornecedor (nome_fantasia, telefone, email, razao_social, cnpj, endereco) VALUES
  ('Laticínios BomLeite',   '1133334444', 'contato@bomleite.com.br',   'BomLeite Ind. Ltda',     '11111111000101', 'Rua Leiteira, 100'),
  ('Bebidas RefrescaMax',   '1144445555', 'vendas@refrescamax.com.br', 'RefrescaMax Com. Ltda',  '22222222000102', 'Av. das Bebidas, 50'),
  ('Hortifruti Verde Vivo', '1155556666', 'verde@verdevivo.com.br',    'Verde Vivo Agro Ltda',   '33333333000103', 'Estrada Rural, 20'),
  ('Padaria Aroma Pão',     '1166667777', 'aroma@aromapao.com.br',     'Aroma Pão Ind. Ltda',    '44444444000104', 'Rua do Forno, 5'),
  ('Limpeza CleanTotal',    '1177778888', 'clean@cleantotal.com.br',   'CleanTotal Dist. Ltda',  '55555555000105', 'Rua Higiene, 300'),
  ('Higiene MaisBella',     '1188889999', 'bella@maisbella.com.br',    'MaisBella Prod. Ltda',   '66666666000106', 'Av. da Beleza, 80'),
  ('Frigorífico BomCorte',  '1199990000', 'vendas@bomcorte.com.br',    'BomCorte Carnes Ltda',   '77777777000107', 'Rua do Açougue, 15'),
  ('Congelados IcePack',    '1122221111', 'ice@icepack.com.br',        'IcePack Alimentos Ltda', '88888888000108', 'Rua Fria, 99'),
  ('Mercearia GrãoForte',   '1133332222', 'grao@graoforte.com.br',     'GrãoForte Dist. Ltda',   '99999999000109', 'Av. dos Grãos, 400'),
  ('Frios Gelatto',         '1144443333', 'frios@gelatto.com.br',      'Gelatto Frios Ltda',     '10101010000110', 'Rua Gelada, 60');

-- ------------------------------------------------------------
-- funcionario
-- ------------------------------------------------------------
INSERT INTO funcionario (id_funcionario, nome_funcionario, cargo, senha, cpf, telefone, login) VALUES
  ('F001', 'João Batista Silva',    'Caixa',      'senha123',  '111.111.111-01', '11911110001', 'joao.silva'),
  ('F002', 'Maria Aparecida Nunes', 'Caixa',      'senha123',  '222.222.222-02', '11922220002', 'maria.nunes'),
  ('F003', 'Pedro Henrique Gomes',  'Caixa',      'senha123',  '333.333.333-03', '11933330003', 'pedro.gomes'),
  ('F004', 'Lucia Fernanda Torres', 'Gerente',    'gerente01', '444.444.444-04', '11944440004', 'lucia.torres'),
  ('F005', 'Rafael Souza Dias',     'Caixa',      'senha123',  '555.555.555-05', '11955550005', 'rafael.dias'),
  ('F006', 'Camila Rocha Pires',    'Caixa',      'senha123',  '666.666.666-06', '11966660006', 'camila.rocha'),
  ('F007', 'Anderson Lima Cruz',    'Estoquista', 'senha123',  '777.777.777-07', '11977770007', 'anderson.lima'),
  ('F008', 'Bianca Martins Faro',   'Caixa',      'senha123',  '888.888.888-08', '11988880008', 'bianca.martins');

-- ------------------------------------------------------------
-- produto
-- ------------------------------------------------------------
INSERT INTO produto (nome_produto, descricao_produto, preco_compra, preco_venda, codigo_barras, validade, categoria_id) VALUES
  ('Leite Integral 1L',        'Leite integral tipo A',             2.50,  4.99, '7891000010001', CURRENT_DATE + 10,  1),
  ('Queijo Mussarela 500g',    'Queijo mussarela fatiado',          8.00, 15.90, '7891000010002', CURRENT_DATE + 5,   1),
  ('Iogurte Natural 170g',     'Iogurte natural sem açúcar',        1.20,  2.49, '7891000010003', CURRENT_DATE + 60,  1),
  ('Manteiga 200g',            'Manteiga com sal',                  4.50,  8.99, '7891000010004', CURRENT_DATE + 20,  1),
  ('Refrigerante Cola 2L',     'Refrigerante sabor cola',           3.00,  6.50, '7891000020001', CURRENT_DATE + 180, 2),
  ('Suco de Laranja 1L',       'Suco de laranja integral',          4.00,  7.90, '7891000020002', CURRENT_DATE + 25,  2),
  ('Água Mineral 500ml',       'Água mineral sem gás',              0.80,  1.99, '7891000020003', CURRENT_DATE + 365, 2),
  ('Cerveja Lata 350ml',       'Cerveja pilsen lata',               2.20,  4.49, '7891000020004', CURRENT_DATE + 120, 2),
  ('Banana Prata 1kg',         'Banana prata fresca',               1.50,  3.49, '7891000030001', CURRENT_DATE + 7,   3),
  ('Tomate Italiano 1kg',      'Tomate italiano selecionado',       2.00,  4.29, '7891000030002', CURRENT_DATE + 6,   3),
  ('Alface Crespa',            'Alface crespa hidropônica',         0.90,  2.49, '7891000030003', CURRENT_DATE + 4,   3),
  ('Pão Francês 1kg',          'Pão francês fresquinho',            4.00,  7.50, '7891000040001', CURRENT_DATE + 2,   4),
  ('Bolo de Cenoura 400g',     'Bolo de cenoura com cobertura',     5.00,  9.90, '7891000040002', CURRENT_DATE + 15,  4),
  ('Detergente Líquido 500ml', 'Detergente neutro multiuso',        1.10,  2.79, '7891000050001', CURRENT_DATE + 730, 5),
  ('Água Sanitária 1L',        'Água sanitária com cloro ativo',    1.50,  3.49, '7891000050002', CURRENT_DATE + 365, 5),
  ('Shampoo 400ml',            'Shampoo para cabelos normais',      5.00, 11.90, '7891000060001', CURRENT_DATE + 720, 6),
  ('Sabonete 90g',             'Sabonete antibacteriano',           0.80,  2.29, '7891000060002', CURRENT_DATE + 900, 6),
  ('Frango Inteiro 1kg',       'Frango inteiro resfriado',          6.00, 11.99, '7891000070001', CURRENT_DATE + 5,   7),
  ('Carne Moída 500g',         'Carne moída bovina',                7.50, 14.90, '7891000070002', CURRENT_DATE + 3,   7),
  ('Pizza Congelada 500g',     'Pizza de queijo congelada',         6.50, 13.90, '7891000080001', CURRENT_DATE + 90,  8),
  ('Hambúrguer Congelado 4un', 'Hambúrguer bovino congelado',       5.00, 10.49, '7891000080002', CURRENT_DATE + 120, 8),
  ('Arroz Branco 5kg',         'Arroz branco tipo 1',               9.00, 17.90, '7891000090001', CURRENT_DATE + 540, 9),
  ('Feijão Carioca 1kg',       'Feijão carioca selecionado',        3.50,  7.49, '7891000090002', CURRENT_DATE + 360, 9),
  ('Óleo de Soja 900ml',       'Óleo de soja refinado',             4.00,  8.29, '7891000090003', CURRENT_DATE + 400, 9),
  ('Macarrão Espaguete 500g',  'Macarrão espaguete n°8',            1.80,  3.99, '7891000090004', CURRENT_DATE + 500, 9),
  ('Presunto Cozido 200g',     'Presunto cozido fatiado',           4.50,  9.90, '7891000100001', CURRENT_DATE + 12,  10),
  ('Salame Italiano 150g',     'Salame italiano fatiado',           6.00, 13.49, '7891000100002', CURRENT_DATE + 22,  10);

-- ------------------------------------------------------------
-- estoque
-- ------------------------------------------------------------
INSERT INTO estoque (quantidade, estoque_minimo, produto_id) VALUES
  (50,  10, 1),
  (30,   5, 2),
  (80,  20, 3),
  (40,  10, 4),
  (100, 20, 5),
  (60,  15, 6),
  (200, 50, 7),
  (150, 30, 8),
  (35,  10, 9),
  (40,  10, 10),
  (25,   5, 11),
  (20,   5, 12),
  (15,   5, 13),
  (90,  20, 14),
  (70,  15, 15),
  (45,  10, 16),
  (100, 30, 17),
  (25,   5, 18),
  (20,   5, 19),
  (35,  10, 20),
  (50,  10, 21),
  (80,  20, 22),
  (60,  15, 23),
  (55,  15, 24),
  (70,  20, 25),
  (30,   8, 26),
  (28,   8, 27);

-- ------------------------------------------------------------
-- compra
-- ------------------------------------------------------------
INSERT INTO compra (data_compra, fornecedorid_fornecedor) VALUES
  (CURRENT_DATE - 60, 1),
  (CURRENT_DATE - 55, 2),
  (CURRENT_DATE - 50, 3),
  (CURRENT_DATE - 45, 4),
  (CURRENT_DATE - 40, 5),
  (CURRENT_DATE - 35, 6),
  (CURRENT_DATE - 30, 7),
  (CURRENT_DATE - 25, 8),
  (CURRENT_DATE - 20, 9),
  (CURRENT_DATE - 15, 10);

-- ------------------------------------------------------------
-- item_compra
-- ------------------------------------------------------------
INSERT INTO item_compra (id_item_compra, quatidade_compra, preco_compra, compraid_compra, produto_Pkeyid_prodroduto) VALUES
  ('IC001', 100, 2.50,  1,  1),
  ('IC002',  60, 8.00,  1,  2),
  ('IC003', 120, 1.20,  1,  3),
  ('IC004',  80, 4.50,  1,  4),
  ('IC005', 150, 3.00,  2,  5),
  ('IC006', 100, 4.00,  2,  6),
  ('IC007', 300, 0.80,  2,  7),
  ('IC008', 200, 2.20,  2,  8),
  ('IC009',  50, 1.50,  3,  9),
  ('IC010',  60, 2.00,  3, 10),
  ('IC011',  40, 0.90,  3, 11),
  ('IC012',  30, 4.00,  4, 12),
  ('IC013',  25, 5.00,  4, 13),
  ('IC014', 120, 1.10,  5, 14),
  ('IC015', 100, 1.50,  5, 15),
  ('IC016',  80, 5.00,  6, 16),
  ('IC017', 150, 0.80,  6, 17),
  ('IC018',  40, 6.00,  7, 18),
  ('IC019',  35, 7.50,  7, 19),
  ('IC020',  60, 6.50,  8, 20),
  ('IC021',  80, 5.00,  8, 21),
  ('IC022', 100, 9.00,  9, 22),
  ('IC023',  90, 3.50,  9, 23),
  ('IC024',  80, 4.00,  9, 24),
  ('IC025', 100, 1.80,  9, 25),
  ('IC026',  50, 4.50, 10, 26),
  ('IC027',  45, 6.00, 10, 27);

-- ------------------------------------------------------------
-- venda
-- ------------------------------------------------------------
INSERT INTO venda (data_venda, valor_total, clienteid_cliente, funcionarioid_funcionario) VALUES
  (DATE_TRUNC('month', CURRENT_DATE)::date + 0,  125.90, 1, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 1,  210.50, 2, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 2,   89.00, 3, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 3,  155.75, 4, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 4,  310.00, 5, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 5,  180.20, 6, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 6,  220.00, 7, 'F001'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 0,  430.00, 8,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 1,  115.60, 9,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 2,   75.00, 10, 'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 3,  260.40, 1,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 4,  190.00, 2,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 5,  340.80, 3,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 6,  105.20, 4,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 7,  225.90, 5,  'F002'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 0,  150.00, 6,  'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 2,  200.00, 7,  'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 4,  175.50, 8,  'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 6,  310.00, 9,  'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 8,  130.75, 10, 'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 9,  290.00, 1,  'F003'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 1,  500.00, 2, 'F005'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 3,  320.00, 3, 'F005'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 5,  410.00, 4, 'F005'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 7,  280.00, 5, 'F005'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 0,  140.00, 6,  'F006'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 2,  160.00, 7,  'F006'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 4,  185.50, 8,  'F006'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 6,  210.25, 9,  'F006'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 8,  120.00, 10, 'F006'),
  (DATE_TRUNC('month', CURRENT_DATE)::date + 9,  175.80, 1,  'F006');

-- ------------------------------------------------------------
-- item_venda
-- ------------------------------------------------------------
INSERT INTO item_venda (id_item_venda, quantidade, preco_unitario, desconto, vendaid_venda, produto_Pkeyid_prodroduto) VALUES
  ('IV001', 2,  4.99, NULL, 1,  1),
  ('IV002', 1, 15.90, NULL, 1,  2),
  ('IV003', 3,  7.90, NULL, 1,  6),
  ('IV004', 5,  1.99, NULL, 1,  7),
  ('IV005', 4,  4.99, NULL, 2,  1),
  ('IV006', 2, 17.90, NULL, 2, 22),
  ('IV007', 3,  7.49, NULL, 2, 23),
  ('IV008', 2, 11.99, NULL, 2, 18),
  ('IV009', 2,  8.29, NULL, 3, 24),
  ('IV010', 5,  3.99, NULL, 3, 25),
  ('IV011', 3,  4.49, NULL, 3,  8),
  ('IV012', 1, 15.90, NULL, 4,  2),
  ('IV013', 2, 13.90, NULL, 4, 20),
  ('IV014', 3,  9.90, NULL, 4, 26),
  ('IV015', 2, 10.49, NULL, 4, 21),
  ('IV016', 5, 17.90, NULL, 5, 22),
  ('IV017', 4,  7.49, NULL, 5, 23),
  ('IV018', 3, 11.99, NULL, 5, 18),
  ('IV019', 2, 14.90, NULL, 5, 19),
  ('IV020', 2,  4.99, NULL, 6,  1),
  ('IV021', 3, 15.90, 1.50, 6,  2),
  ('IV022', 4,  2.49, NULL, 6,  3),
  ('IV023', 1,  8.99, NULL, 6,  4),
  ('IV024', 5,  6.50, NULL, 6,  5),
  ('IV025', 2, 13.49, NULL, 7, 27),
  ('IV026', 3,  9.90, NULL, 7, 26),
  ('IV027', 4, 10.49, NULL, 7, 21),
  ('IV028', 5,  2.29, NULL, 7, 17),
  ('IV029',10, 17.90, NULL, 8, 22),
  ('IV030', 5,  7.49, NULL, 8, 23),
  ('IV031', 4,  8.29, NULL, 8, 24),
  ('IV032', 6,  3.99, NULL, 8, 25),
  ('IV033', 3,  6.50, NULL, 9,  5),
  ('IV034', 2,  7.90, NULL, 9,  6),
  ('IV035', 5,  1.99, NULL, 9,  7),
  ('IV036', 1,  4.49, NULL, 9,  8),
  ('IV037', 5,  1.99, NULL, 10, 7),
  ('IV038', 4,  3.99, NULL, 10, 25),
  ('IV039', 3,  2.79, NULL, 10, 14),
  ('IV040', 3, 17.90, NULL, 11, 22),
  ('IV041', 2,  7.49, NULL, 11, 23),
  ('IV042', 2, 11.99, NULL, 11, 18),
  ('IV043', 4,  9.90, NULL, 11, 26),
  ('IV044', 2, 13.90, NULL, 12, 20),
  ('IV045', 3, 10.49, NULL, 12, 21),
  ('IV046', 1, 14.90, NULL, 12, 19),
  ('IV047', 5,  8.99, NULL, 12,  4),
  ('IV048', 5, 17.90, NULL, 13, 22),
  ('IV049', 3,  7.49, NULL, 13, 23),
  ('IV050', 4,  3.99, NULL, 13, 25),
  ('IV051', 2, 11.99, NULL, 13, 18),
  ('IV052', 3, 14.90, NULL, 13, 19),
  ('IV053', 2,  4.99, NULL, 14,  1),
  ('IV054', 3,  6.50, NULL, 14,  5),
  ('IV055', 1,  9.90, NULL, 14, 26),
  ('IV056', 4, 17.90, NULL, 15, 22),
  ('IV057', 2,  7.49, NULL, 15, 23),
  ('IV058', 3,  8.29, NULL, 15, 24),
  ('IV059', 2, 13.49, NULL, 15, 27),
  ('IV060', 2, 17.90, NULL, 16, 22),
  ('IV061', 3,  7.49, NULL, 16, 23),
  ('IV062', 2, 11.99, NULL, 16, 18),
  ('IV063', 3, 13.90, NULL, 17, 20),
  ('IV064', 4, 10.49, NULL, 17, 21),
  ('IV065', 2, 14.90, NULL, 17, 19),
  ('IV066', 3, 17.90, NULL, 18, 22),
  ('IV067', 2,  7.49, NULL, 18, 23),
  ('IV068', 2,  8.29, NULL, 18, 24),
  ('IV069', 1, 13.49, NULL, 18, 27),
  ('IV070', 5, 17.90, NULL, 19, 22),
  ('IV071', 4,  7.49, NULL, 19, 23),
  ('IV072', 3,  8.29, NULL, 19, 24),
  ('IV073', 2,  3.99, NULL, 19, 25),
  ('IV074', 2,  4.99, NULL, 20,  1),
  ('IV075', 3,  6.50, NULL, 20,  5),
  ('IV076', 2,  9.90, NULL, 20, 13),
  ('IV077', 5, 17.90, NULL, 21, 22),
  ('IV078', 3,  7.49, NULL, 21, 23),
  ('IV079', 4,  8.29, NULL, 21, 24),
  ('IV080', 2, 13.49, NULL, 21, 27),
  ('IV081',10, 17.90, NULL, 22, 22),
  ('IV082', 8,  7.49, NULL, 22, 23),
  ('IV083', 6,  8.29, NULL, 22, 24),
  ('IV084', 5,  3.99, NULL, 22, 25),
  ('IV085', 5, 17.90, NULL, 23, 22),
  ('IV086', 4,  7.49, NULL, 23, 23),
  ('IV087', 3, 13.49, NULL, 23, 27),
  ('IV088', 6, 17.90, NULL, 24, 22),
  ('IV089', 5,  7.49, NULL, 24, 23),
  ('IV090', 4,  8.29, NULL, 24, 24),
  ('IV091', 4, 17.90, NULL, 25, 22),
  ('IV092', 3,  7.49, NULL, 25, 23),
  ('IV093', 2, 13.49, NULL, 25, 27),
  ('IV094', 3, 17.90, NULL, 26, 22),
  ('IV095', 2,  7.49, NULL, 26, 23),
  ('IV096', 1, 11.99, NULL, 26, 18),
  ('IV097', 2, 13.90, NULL, 27, 20),
  ('IV098', 3, 10.49, NULL, 27, 21),
  ('IV099', 1,  8.99, NULL, 27,  4),
  ('IV100', 3, 17.90, NULL, 28, 22),
  ('IV101', 2,  7.49, NULL, 28, 23),
  ('IV102', 2,  8.29, NULL, 28, 24),
  ('IV103', 4, 17.90, NULL, 29, 22),
  ('IV104', 2,  7.49, NULL, 29, 23),
  ('IV105', 1, 13.49, NULL, 29, 27),
  ('IV106', 2,  4.99, NULL, 30,  1),
  ('IV107', 3,  6.50, NULL, 30,  5),
  ('IV108', 2,  9.90, NULL, 30, 26),
  ('IV109', 3, 17.90, NULL, 31, 22),
  ('IV110', 2,  7.49, NULL, 31, 23),
  ('IV111', 2, 13.49, NULL, 31, 27);

-- ------------------------------------------------------------
-- pagamento
-- ------------------------------------------------------------
INSERT INTO pagamento (tipo, valor, vendaid_venda) VALUES
  ('Pix',      125.90,  1),
  ('Crédito',  210.50,  2),
  ('Débito',    89.00,  3),
  ('Dinheiro', 155.75,  4),
  ('Pix',      310.00,  5),
  ('Crédito',  180.20,  6),
  ('Débito',   220.00,  7),
  ('Pix',      430.00,  8),
  ('Crédito',  115.60,  9),
  ('Dinheiro',  75.00, 10),
  ('Pix',      260.40, 11),
  ('Débito',   190.00, 12),
  ('Crédito',  340.80, 13),
  ('Pix',      105.20, 14),
  ('Débito',   225.90, 15),
  ('Pix',      150.00, 16),
  ('Crédito',  200.00, 17),
  ('Débito',   175.50, 18),
  ('Pix',      310.00, 19),
  ('Dinheiro', 130.75, 20),
  ('Crédito',  290.00, 21),
  ('Pix',      500.00, 22),
  ('Crédito',  320.00, 23),
  ('Débito',   410.00, 24),
  ('Dinheiro', 280.00, 25),
  ('Pix',      140.00, 26),
  ('Crédito',  160.00, 27),
  ('Débito',   185.50, 28),
  ('Pix',      210.25, 29),
  ('Dinheiro', 120.00, 30),
  ('Crédito',  175.80, 31);


-- ============================================================
-- RELATÓRIOS
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
    f.nome_funcionario                  AS nome_funcionario,
    COUNT(v.id_venda)                   AS total_vendas,
    SUM(v.valor_total)                  AS valor_total_vendido,
    ROUND(SUM(v.valor_total)
        / COUNT(v.id_venda), 2)         AS ticket_medio
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
