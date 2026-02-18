-- ============================================================================
-- STEP 4 (Option B): Semantic Model Setup via Manual Upload
-- ============================================================================
-- This script creates the stage and provides instructions for manually
-- uploading the semantic model YAML file.
--
-- Use this option if you prefer to upload the file manually via Snowsight
-- or if Git integration is not available in your account.
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Create a stage to store semantic models
CREATE OR REPLACE STAGE semantic_models
    ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);

-- ============================================================================
-- MANUAL UPLOAD INSTRUCTIONS
-- ============================================================================
-- After running the above statement, upload the semantic model file manually:
--
-- Option 1: Via Snowsight UI
--   1. Navigate to Data > Databases > SI_DB > RETAIL > Stages
--   2. Click on SEMANTIC_MODELS stage
--   3. Click "+ Files" button in the top right
--   4. Select the 'marketing_campaigns.yaml' file from this repo
--   5. Click "Upload"
--
-- Option 2: Via SnowSQL CLI
--   PUT file://path/to/marketing_campaigns.yaml @semantic_models AUTO_COMPRESS=FALSE;
--
-- ============================================================================

-- Verify the file was uploaded (run after manual upload)
LIST @semantic_models;

SELECT 'Step 4: Stage created. Please upload marketing_campaigns.yaml manually.' AS status;
