-- ============================================================================
-- STEP 3: Load Data from S3
-- ============================================================================
-- This script creates external stages pointing to S3 and loads data into tables.
-- Data source: s3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/
-- ============================================================================

USE ROLE snowflake_intelligence_admin;
USE DATABASE dash_db_si;
USE SCHEMA retail;
USE WAREHOUSE dash_wh_si;

-- Create stage and load Marketing Campaign Metrics
CREATE OR REPLACE STAGE swt_marketing_data_stage
    FILE_FORMAT = swt_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/marketing/';

COPY INTO marketing_campaign_metrics
    FROM @swt_marketing_data_stage;

-- Create stage and load Products
CREATE OR REPLACE STAGE swt_products_data_stage
    FILE_FORMAT = swt_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/product/';

COPY INTO products
    FROM @swt_products_data_stage;

-- Create stage and load Sales
CREATE OR REPLACE STAGE swt_sales_data_stage
    FILE_FORMAT = swt_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/sales/';

COPY INTO sales
    FROM @swt_sales_data_stage;

-- Create stage and load Social Media
CREATE OR REPLACE STAGE swt_social_media_data_stage
    FILE_FORMAT = swt_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/social_media/';

COPY INTO social_media
    FROM @swt_social_media_data_stage;

-- Create stage and load Support Cases
CREATE OR REPLACE STAGE swt_support_data_stage
    FILE_FORMAT = swt_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/support/';

COPY INTO support_cases
    FROM @swt_support_data_stage;

-- Verify data loaded
SELECT 'marketing_campaign_metrics' AS table_name, COUNT(*) AS row_count FROM marketing_campaign_metrics
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'social_media', COUNT(*) FROM social_media
UNION ALL
SELECT 'support_cases', COUNT(*) FROM support_cases;
