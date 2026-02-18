-- ============================================================================
-- STEP 4 (Option A): Semantic Model Setup via Git Integration
-- ============================================================================
-- This script uses Git integration to pull the semantic model YAML file
-- from GitHub and stores it in a Snowflake stage.
--
-- Use this option if you want automatic syncing with the GitHub repo.
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Create a stage to store semantic models
CREATE OR REPLACE STAGE semantic_models
    ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);

-- Create Git API integration
CREATE OR REPLACE API INTEGRATION si_git_api_integration
    API_PROVIDER = git_https_api
    API_ALLOWED_PREFIXES = ('https://github.com/Snowflake-Labs')
    ENABLED = TRUE;

-- Create Git repository connection
CREATE OR REPLACE GIT REPOSITORY si_git_repo
    API_INTEGRATION = si_git_api_integration
    ORIGIN = 'https://github.com/Snowflake-Labs/sfguide-getting-started-with-snowflake-intelligence';

-- Copy semantic model from Git repo to stage
COPY FILES INTO @semantic_models
    FROM @si_git_repo/branches/main/
    FILES = ('marketing_campaigns.yaml');

-- Verify the file was copied
LIST @semantic_models;

SELECT 'Step 4 Complete: Semantic model uploaded via Git integration!' AS status;
