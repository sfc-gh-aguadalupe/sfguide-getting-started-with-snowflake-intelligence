-- ============================================================================
-- STEP 1: Setup Roles, Warehouse, and Databases
-- ============================================================================
-- This script creates the foundational infrastructure for the lab:
--   - Role: si_admin
--   - Warehouse: si_wh
--   - Databases: si_db, si_agents_db
--   - Schemas: si_db.retail, si_agents_db.agents
-- ============================================================================

USE ROLE ACCOUNTADMIN;

-- Create a dedicated role for this lab
CREATE OR REPLACE ROLE si_admin;
GRANT CREATE WAREHOUSE ON ACCOUNT TO ROLE si_admin;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE si_admin;
GRANT CREATE INTEGRATION ON ACCOUNT TO ROLE si_admin;

-- Grant the role to current user
SET current_user = (SELECT CURRENT_USER());
GRANT ROLE si_admin TO USER IDENTIFIER($current_user);
ALTER USER SET DEFAULT_ROLE = si_admin;
ALTER USER SET DEFAULT_WAREHOUSE = si_wh;

-- Switch to the new role
USE ROLE si_admin;

-- Create warehouse
CREATE OR REPLACE WAREHOUSE si_wh WITH WAREHOUSE_SIZE = 'LARGE';

-- Create databases and schemas
CREATE OR REPLACE DATABASE si_db;
CREATE OR REPLACE SCHEMA si_db.retail;

CREATE DATABASE IF NOT EXISTS si_agents_db;
CREATE SCHEMA IF NOT EXISTS si_agents_db.agents;

-- Grant permission to create agents
GRANT CREATE AGENT ON SCHEMA si_agents_db.agents TO ROLE si_admin;

-- Set context for subsequent scripts
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

SELECT 'Step 1 Complete: Roles, warehouse, and databases created successfully!' AS status;
