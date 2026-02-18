-- ============================================================================
-- STEP 7: Cleanup (Manual Path)
-- ============================================================================
-- This script removes all objects created during the MANUAL path of the lab.
-- Run this when you're finished with the lab to clean up your account.
-- 
-- WARNING: This will permanently delete all lab data and objects!
-- ============================================================================

USE ROLE ACCOUNTADMIN;

-- Drop the databases (this removes all tables, stages, and schemas within)
DROP DATABASE IF EXISTS si_db;
DROP DATABASE IF EXISTS si_agents_db;

-- Drop the warehouse
DROP WAREHOUSE IF EXISTS si_wh;

-- Drop the notification integration
DROP INTEGRATION IF EXISTS si_email_integration;

-- Drop the Git API integration
DROP INTEGRATION IF EXISTS si_git_api_integration;

-- Drop the role (must be done last, after dropping objects owned by it)
DROP ROLE IF EXISTS si_admin;

SELECT 'Cleanup Complete: All Manual path lab objects have been removed!' AS status;
