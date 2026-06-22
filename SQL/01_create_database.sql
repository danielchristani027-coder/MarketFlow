-- ============================================================
-- 01_create_database.sql
-- Criação do banco de dados Market Flow
-- ============================================================

CREATE DATABASE market_flow
    WITH
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE   = 'pt_BR.UTF-8'
    TEMPLATE   = template0;

COMMENT ON DATABASE market_flow IS 'Banco de dados do sistema de mercado Market Flow';
