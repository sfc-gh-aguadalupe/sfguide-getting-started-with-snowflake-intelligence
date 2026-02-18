-- ============================================================================
-- STEP 4 (Option B): Semantic Model Setup via Manual Upload
-- ============================================================================
-- This script creates the stage for storing the YAML file and creates the
-- Semantic View required for Snowflake Intelligence.
--
-- The Semantic View is REQUIRED for the database to appear in the
-- Snowflake Intelligence agent creation UI dropdown.
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Create a stage to store semantic models (optional, for YAML file storage)
CREATE OR REPLACE STAGE semantic_models
    ENCRYPTION = (TYPE = 'SNOWFLAKE_SSE')
    DIRECTORY = (ENABLE = TRUE);

-- ============================================================================
-- Create the Semantic View from YAML specification
-- This is REQUIRED for SI_DB to appear in Snowflake Intelligence UI
-- ============================================================================
CALL SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(
  'si_db.retail',
  $$name: Sales_And_Marketing_Data
tables:
  - name: MARKETING_CAMPAIGN_METRICS
    base_table:
      database: SI_DB
      schema: RETAIL
      table: MARKETING_CAMPAIGN_METRICS
    primary_key:
      columns:
        - CATEGORY
    dimensions:
      - name: CAMPAIGN_NAME
        synonyms:
          - ad_campaign
          - marketing_campaign
          - promo_name
        description: The name of the marketing campaign.
        expr: CAMPAIGN_NAME
        data_type: VARCHAR(16777216)
      - name: CATEGORY
        synonyms:
          - type
          - classification
          - group
        description: The category of the marketing campaign.
        expr: CATEGORY
        data_type: VARCHAR(16777216)
    facts:
      - name: CLICKS
        synonyms:
          - click_throughs
          - ad_clicks
        description: The total number of times users clicked on an advertisement.
        expr: CLICKS
        data_type: NUMBER(38,0)
      - name: IMPRESSIONS
        synonyms:
          - views
          - ad_views
        description: The total number of times an ad was displayed.
        expr: IMPRESSIONS
        data_type: NUMBER(38,0)
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - calendar_date
        description: Date on which the marketing campaign metrics were recorded.
        expr: DATE
        data_type: DATE
  - name: PRODUCTS
    base_table:
      database: SI_DB
      schema: RETAIL
      table: PRODUCTS
    primary_key:
      columns:
        - PRODUCT_ID
    dimensions:
      - name: CATEGORY
        synonyms:
          - type
          - product_type
        description: The CATEGORY column represents the type of product being sold.
        expr: CATEGORY
        data_type: VARCHAR(16777216)
      - name: PRODUCT_ID
        synonyms:
          - product_key
          - item_id
        description: Unique identifier for each product in the catalog.
        expr: PRODUCT_ID
        data_type: NUMBER(38,0)
      - name: PRODUCT_NAME
        synonyms:
          - item_name
          - product_title
        description: The name of the product being sold.
        expr: PRODUCT_NAME
        data_type: VARCHAR(16777216)
  - name: SALES
    base_table:
      database: SI_DB
      schema: RETAIL
      table: SALES
    dimensions:
      - name: PRODUCT_ID
        synonyms:
          - product_code
          - item_id
        description: Unique identifier for a product sold.
        expr: PRODUCT_ID
        data_type: NUMBER(38,0)
      - name: REGION
        synonyms:
          - area
          - territory
        description: Geographic region where the sale was made.
        expr: REGION
        data_type: VARCHAR(16777216)
    facts:
      - name: SALES_AMOUNT
        synonyms:
          - total_sales
          - revenue
        description: The total amount of sales generated from a transaction.
        expr: SALES_AMOUNT
        data_type: NUMBER(38,2)
      - name: UNITS_SOLD
        synonyms:
          - quantity_sold
          - items_sold
        description: The total quantity of products sold.
        expr: UNITS_SOLD
        data_type: NUMBER(38,0)
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - sale_date
        description: Date of sale.
        expr: DATE
        data_type: DATE
  - name: SOCIAL_MEDIA
    base_table:
      database: SI_DB
      schema: RETAIL
      table: SOCIAL_MEDIA
    dimensions:
      - name: CATEGORY
        synonyms:
          - type
          - classification
        description: The category of social media content.
        expr: CATEGORY
        data_type: VARCHAR(16777216)
      - name: INFLUENCER
        synonyms:
          - content_creator
          - brand_ambassador
        description: The name of the social media influencer.
        expr: INFLUENCER
        data_type: VARCHAR(16777216)
      - name: PLATFORM
        synonyms:
          - channel
          - social_media_channel
        description: The social media platform.
        expr: PLATFORM
        data_type: VARCHAR(16777216)
    facts:
      - name: MENTIONS
        synonyms:
          - citations
          - references
        description: The number of times a brand is mentioned on social media.
        expr: MENTIONS
        data_type: NUMBER(38,0)
    time_dimensions:
      - name: DATE
        synonyms:
          - day
          - posting_date
        description: Date on which social media data was collected.
        expr: DATE
        data_type: DATE
relationships:
  - name: SALES_TO_PRODUCT
    left_table: SALES
    right_table: PRODUCTS
    relationship_columns:
      - left_column: PRODUCT_ID
        right_column: PRODUCT_ID
    relationship_type: many_to_one
    join_type: inner
  - name: MARKETING_TO_SOCIAL
    left_table: SOCIAL_MEDIA
    right_table: MARKETING_CAMPAIGN_METRICS
    relationship_columns:
      - left_column: CATEGORY
        right_column: CATEGORY
    relationship_type: many_to_one
    join_type: inner
$$
);

-- Verify semantic view was created
SHOW SEMANTIC VIEWS IN DATABASE si_db;

-- ============================================================================
-- OPTIONAL: Manual YAML Upload Instructions
-- ============================================================================
-- If you want to also store the YAML file on the stage for reference:
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
-- ============================================================================

SELECT 'Step 4 Complete: Semantic View created! SI_DB will now appear in agent creation UI.' AS status;
