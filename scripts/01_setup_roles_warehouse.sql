-- ============================================================================
-- STEP 1: Setup Roles, Warehouse, and Databases
-- ============================================================================
-- This script creates the foundational infrastructure for the lab:
--   - Role: snowflake_intelligence_admin
--   - Warehouse: dash_wh_si
--   - Databases: dash_db_si, snowflake_intelligence
--   - Schemas: dash_db_si.retail, snowflake_intelligence.agents
-- ============================================================================

USE ROLE ACCOUNTADMIN;

-- Create a dedicated role for this lab
CREATE OR REPLACE ROLE snowflake_intelligence_admin;
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE snowflake_intelligence_admin;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE snowflake_intelligence_admin;
GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE snowflake_intelligence_admin;

-- Grant the role to current user
SET current_user = (SELECT CURRENT_USER());
GRANT ROLE snowflake_intelligence_admin TO USER IDENTIFIER($current_user);
ALTER USER SET DEFAULT_ROLE = snowflake_intelligence_admin;
ALTER USER SET DEFAULT_WAREHOUSE = dash_wh_si;

-- Switch to the new role
USE ROLE snowflake_intelligence_admin;

-- Create warehouse
CREATE OR REPLACE WAREHOUSE dash_wh_si WITH WAREHOUSE_SIZE = 'LARGE';

-- Create databases and schemas
CREATE OR REPLACE DATABASE dash_db_si;
CREATE OR REPLACE SCHEMA dash_db_si.retail;

CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;

-- Grant permission to create agents
GRANT CREATE AGENT ON SCHEMA snowflake_intelligence.agents TO ROLE snowflake_intelligence_admin;

-- Set context for subsequent scripts
USE DATABASE dash_db_si;
USE SCHEMA retail;
USE WAREHOUSE dash_wh_si;

SELECT 'Step 1 Complete: Roles, warehouse, and databases created successfully!' AS status;
