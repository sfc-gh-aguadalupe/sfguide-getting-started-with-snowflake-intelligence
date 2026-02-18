-- ============================================================================
-- STEP 6: Cleanup
-- ============================================================================
-- This script removes all objects created during the lab.
-- Run this when you're finished with the lab to clean up your account.
-- 
-- WARNING: This will permanently delete all lab data and objects!
-- ============================================================================

USE ROLE ACCOUNTADMIN;

-- Drop the databases (this removes all tables, stages, and schemas within)
DROP DATABASE IF EXISTS dash_db_si;
DROP DATABASE IF EXISTS snowflake_intelligence;

-- Drop the warehouse
DROP WAREHOUSE IF EXISTS dash_wh_si;

-- Drop the notification integration
DROP INTEGRATION IF EXISTS email_integration;

-- Drop the Git API integration
DROP INTEGRATION IF EXISTS snowflake_labs_si_git_api_integration;

-- Drop the role (must be done last, after dropping objects owned by it)
DROP ROLE IF EXISTS snowflake_intelligence_admin;

SELECT 'Cleanup Complete: All lab objects have been removed!' AS status;
