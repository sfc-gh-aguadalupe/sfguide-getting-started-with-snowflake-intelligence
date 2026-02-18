-- ============================================================================
-- STEP 6: Cortex Search Service Setup
-- ============================================================================
-- This script creates an aggregated support cases summary using Cortex AI
-- and sets up a Cortex Search service for the agent to answer questions
-- based on high-level trends from support tickets.
--
-- NOTE: These SQL statements may take 3-5 minutes to run.
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Use AI_AGG to aggregate support cases summary and insert into a new table
CREATE OR REPLACE TABLE aggregated_support_cases_summary AS
SELECT 
    ai_agg(
        transcript,
        'Read and analyze all support cases to provide a long-form text summary in no less than 5000 words.'
    ) AS summary
FROM support_cases;

-- Create Cortex Search service on the aggregated summary table
CREATE OR REPLACE CORTEX SEARCH SERVICE aggregated_support_cases 
    ON summary 
    ATTRIBUTES summary 
    WAREHOUSE = si_wh 
    EMBEDDING_MODEL = 'snowflake-arctic-embed-m-v1.5' 
    TARGET_LAG = '1 hour' 
    INITIALIZE = ON_SCHEDULE 
AS (
    SELECT summary
    FROM aggregated_support_cases_summary
);

SELECT 'Step 6 Complete: Cortex Search service created!' AS status;
