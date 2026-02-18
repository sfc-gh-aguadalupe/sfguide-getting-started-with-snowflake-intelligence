-- ============================================================================
-- STEP 2: Create Tables
-- ============================================================================
-- This script creates the 5 tables for our retail analytics data:
--   - marketing_campaign_metrics: Ad campaign performance data
--   - products: Product catalog
--   - sales: Sales transactions
--   - social_media: Social media mentions and engagement
--   - support_cases: Customer support tickets
-- ============================================================================

USE ROLE snowflake_intelligence_admin;
USE DATABASE dash_db_si;
USE SCHEMA retail;
USE WAREHOUSE dash_wh_si;

-- Create file format for CSV loading
CREATE OR REPLACE FILE FORMAT swt_csvformat
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    TYPE = 'CSV';

-- Marketing Campaign Metrics table
CREATE OR REPLACE TABLE marketing_campaign_metrics (
    date DATE,
    category VARCHAR(16777216),
    campaign_name VARCHAR(16777216),
    impressions NUMBER(38,0),
    clicks NUMBER(38,0)
);

-- Products table
CREATE OR REPLACE TABLE products (
    product_id NUMBER(38,0),
    product_name VARCHAR(16777216),
    category VARCHAR(16777216)
);

-- Sales table
CREATE OR REPLACE TABLE sales (
    date DATE,
    region VARCHAR(16777216),
    product_id NUMBER(38,0),
    units_sold NUMBER(38,0),
    sales_amount NUMBER(38,2)
);

-- Social Media table
CREATE OR REPLACE TABLE social_media (
    date DATE,
    category VARCHAR(16777216),
    platform VARCHAR(16777216),
    influencer VARCHAR(16777216),
    mentions NUMBER(38,0)
);

-- Support Cases table
CREATE OR REPLACE TABLE support_cases (
    id VARCHAR(16777216),
    title VARCHAR(16777216),
    product VARCHAR(16777216),
    transcript VARCHAR(16777216),
    date DATE
);

SELECT 'Step 2 Complete: All 5 tables created successfully!' AS status;
