-- ============================================================================
-- STEP 4: Semantic Model Setup
-- ============================================================================
-- This script sets up Git integration to pull the semantic model YAML file
-- and creates a stage to store semantic models.
-- ============================================================================

USE ROLE snowflake_intelligence_admin;
USE DATABASE dash_db_si;
USE SCHEMA retail;
USE WAREHOUSE dash_wh_si;

-- Create a stage to store semantic models
CREATE OR REPLACE STAGE semantic_models
    ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);

-- Create Git API integration
CREATE OR REPLACE API INTEGRATION snowflake_labs_si_git_api_integration
    API_PROVIDER = git_https_api
    API_ALLOWED_PREFIXES = ('https://github.com/Snowflake-Labs')
    ENABLED = TRUE;

-- Create Git repository connection
CREATE OR REPLACE GIT REPOSITORY snowflake_labs_sfguide_si_repo
    API_INTEGRATION = snowflake_labs_si_git_api_integration
    ORIGIN = 'https://github.com/Snowflake-Labs/sfguide-getting-started-with-snowflake-intelligence';

-- Copy semantic model from Git repo to stage
COPY FILES INTO @semantic_models
    FROM @snowflake_labs_sfguide_si_repo/branches/main/
    FILES = ('marketing_campaigns.yaml');

-- Verify the file was copied
LIST @semantic_models;

SELECT 'Step 4 Complete: Semantic model uploaded to stage!' AS status;
