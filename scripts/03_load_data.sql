-- ============================================================================
-- STEP 3: Load Data from S3
-- ============================================================================
-- This script creates external stages pointing to S3 and loads data into tables.
-- Data source: s3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Create stage and load Marketing Campaign Metrics
CREATE OR REPLACE STAGE si_marketing_data_stage
    FILE_FORMAT = si_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/marketing/';

COPY INTO marketing_campaign_metrics
    FROM @si_marketing_data_stage;

-- Create stage and load Products
CREATE OR REPLACE STAGE si_products_data_stage
    FILE_FORMAT = si_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/product/';

COPY INTO products
    FROM @si_products_data_stage;

-- Create stage and load Sales
CREATE OR REPLACE STAGE si_sales_data_stage
    FILE_FORMAT = si_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/sales/';

COPY INTO sales
    FROM @si_sales_data_stage;

-- Create stage and load Social Media
CREATE OR REPLACE STAGE si_social_media_data_stage
    FILE_FORMAT = si_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/social_media/';

COPY INTO social_media
    FROM @si_social_media_data_stage;

-- Create stage and load Support Cases
CREATE OR REPLACE STAGE si_support_data_stage
    FILE_FORMAT = si_csvformat
    URL = 's3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/support/';

COPY INTO support_cases
    FROM @si_support_data_stage;

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
