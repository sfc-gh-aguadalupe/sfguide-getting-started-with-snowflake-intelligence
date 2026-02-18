# Getting Started with Snowflake Intelligence - Hands-On Lab

## Overview

In this hands-on lab, you'll learn how to use **Snowflake Intelligence** to create AI-powered agents that can answer business questions using natural language. You'll work with a retail analytics dataset including sales, marketing campaigns, social media, and customer support data.

### What You'll Learn

- Set up infrastructure for Snowflake Intelligence
- Load and organize retail analytics data
- Create and configure a semantic model
- Build an AI agent that answers business questions
- (Bonus) Use Cortex AI for advanced analytics

### Time to Complete

- **Manual Path**: ~45 minutes
- **Cortex Code Path**: ~20 minutes

---

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` role access
- For Cortex Code path: Cortex Code CLI installed and connected to your account

### Verify Your Setup

**Manual Path**: Log into Snowsight and ensure you can access a worksheet.

**Cortex Code Path**: Run this command to verify your connection:
```
cortex connections list
```

---

## Choose Your Path

This lab offers two ways to complete the exercises:

| Path | Best For | How It Works |
|------|----------|--------------|
| **Manual** | Learning SQL details | Copy/paste SQL into Snowsight worksheets |
| **Cortex Code** | Speed & automation | Use natural language prompts in CLI |

> **Tip**: You can mix paths! Use Cortex Code for setup, then switch to Manual for specific steps you want to understand better.

---

## Lab Steps

### Step 1: Setup Roles, Warehouse & Databases

This step creates the foundational infrastructure for the lab.

**Objects Created:**
- Role: `snowflake_intelligence_admin`
- Warehouse: `dash_wh_si`
- Databases: `dash_db_si`, `snowflake_intelligence`
- Schemas: `retail`, `agents`

#### Manual Path

1. Open a new worksheet in Snowsight
2. Copy and paste the contents of `scripts/01_setup_roles_warehouse.sql`
3. Run all statements (Ctrl+Enter or Cmd+Enter)
4. Verify you see: "Step 1 Complete: Roles, warehouse, and databases created successfully!"

#### Cortex Code Path

```
Run the SQL in scripts/01_setup_roles_warehouse.sql
```

#### Verification Checkpoint

```sql
SHOW DATABASES LIKE 'dash_db_si';
SHOW WAREHOUSES LIKE 'dash_wh_si';
```

---

### Step 2: Create Tables

This step creates 5 tables to store our retail analytics data.

**Tables Created:**
| Table | Description |
|-------|-------------|
| `marketing_campaign_metrics` | Ad campaign performance (impressions, clicks) |
| `products` | Product catalog |
| `sales` | Sales transactions by region |
| `social_media` | Social media mentions by platform |
| `support_cases` | Customer support tickets with transcripts |

#### Manual Path

1. Open `scripts/02_create_tables.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements

#### Cortex Code Path

```
Execute the SQL in scripts/02_create_tables.sql to create the tables
```

#### Verification Checkpoint

```sql
SHOW TABLES IN dash_db_si.retail;
```

You should see 5 tables listed.

---

### Step 3: Load Data

This step loads sample data from S3 into the tables.

#### Manual Path

1. Open `scripts/03_load_data.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements
4. Review the row counts in the output

#### Cortex Code Path

```
Load data into the tables using scripts/03_load_data.sql
```

#### Verification Checkpoint

Run this query to verify data was loaded:

```sql
SELECT 'marketing_campaign_metrics' AS table_name, COUNT(*) AS rows FROM dash_db_si.retail.marketing_campaign_metrics
UNION ALL SELECT 'products', COUNT(*) FROM dash_db_si.retail.products
UNION ALL SELECT 'sales', COUNT(*) FROM dash_db_si.retail.sales
UNION ALL SELECT 'social_media', COUNT(*) FROM dash_db_si.retail.social_media
UNION ALL SELECT 'support_cases', COUNT(*) FROM dash_db_si.retail.support_cases;
```

**Expected Results:**
| Table | Approximate Rows |
|-------|-----------------|
| marketing_campaign_metrics | ~30 |
| products | ~30 |
| sales | ~5,000+ |
| social_media | ~200+ |
| support_cases | ~500+ |

---

### Step 4: Setup Semantic Model

The semantic model defines how your data is structured and related, enabling the AI agent to understand your data.

#### Manual Path

1. Open `scripts/04_semantic_model_setup.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements
4. Verify the YAML file appears in the stage listing

#### Cortex Code Path

```
Run scripts/04_semantic_model_setup.sql to set up the semantic model
```

#### Verification Checkpoint

```sql
LIST @dash_db_si.retail.semantic_models;
```

You should see `marketing_campaigns.yaml` in the listing.

---

### Step 5: Email Integration (Optional)

This step enables agents to send email notifications.

#### Manual Path

1. Open `scripts/05_email_integration.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements

#### Cortex Code Path

```
Execute scripts/05_email_integration.sql to enable email notifications
```

> **Note**: Email functionality requires additional account setup. Skip this step if you encounter permission errors.

---

### Step 6: Create the Snowflake Intelligence Agent

Now we'll create an AI agent that can answer questions about your retail data!

#### Manual Path

1. Navigate to **Snowflake Intelligence** in Snowsight (left sidebar)
2. Click **+ Create Agent**
3. Configure the agent:
   - **Name**: `Retail Analytics Agent`
   - **Semantic Model**: Select `@dash_db_si.retail.semantic_models/marketing_campaigns.yaml`
   - **Warehouse**: `dash_wh_si`
4. Click **Create**

#### Cortex Code Path

```
Help me create a Snowflake Intelligence agent named "Retail Analytics Agent" using the semantic model at @dash_db_si.retail.semantic_models/marketing_campaigns.yaml
```

---

### Step 7: Test Your Agent

Try asking your agent these questions:

1. **"What were total sales by region last month?"**
2. **"Which marketing campaigns had the highest click-through rate?"**
3. **"Show me the trend of sales by product category between June 2025 and August 2025"**
4. **"What are the top 5 products by revenue?"**

#### Cortex Code Path

```
Query the Retail Analytics Agent: What were total sales by region last month?
```

---

## Bonus Tracks

Completed the main lab? Try these advanced exercises using Cortex Code!

---

### Bonus 1: Sentiment Analysis with Cortex AI

Use Snowflake's built-in LLM capabilities to analyze customer support cases.

#### Cortex Code Prompts

**Classify support cases by sentiment:**
```
Using Cortex COMPLETE, analyze the support_cases table and classify each case as positive, negative, or neutral based on the transcript. Create a new table with the results.
```

**Summarize common issues:**
```
Use Cortex to summarize the top 5 most common issues found in the support case transcripts
```

**Extract product feedback:**
```
Extract key product feedback and complaints from the support_cases transcripts using Cortex AI
```

---

### Bonus 2: Build a Streamlit Dashboard

Create an interactive dashboard to visualize your retail data.

#### Cortex Code Prompts

**Create a sales dashboard:**
```
Create a Streamlit app that shows:
1. Total sales by region as a bar chart
2. Sales trend over time as a line chart
3. A filter to select date range and product category
Use the data from dash_db_si.retail.sales and products tables.
```

**Add marketing metrics:**
```
Add a new tab to the Streamlit app that shows marketing campaign performance with impressions vs clicks comparison
```

---

### Bonus 3: Extend the Semantic Model

Enhance the semantic model with new calculated metrics.

#### Cortex Code Prompts

**Add Click-Through Rate (CTR):**
```
Add a calculated metric called "click_through_rate" to the marketing_campaigns.yaml semantic model. CTR should be calculated as (clicks / impressions) * 100
```

**Add a new verified query:**
```
Add a verified query to the semantic model for "total sales by product category and region for the last 30 days"
```

**Validate the changes:**
```
Validate the updated semantic model using cortex reflect
```

---

### Bonus 4: Automated Weekly Report

Set up an automated email report.

#### Cortex Code Prompts

**Create a weekly summary task:**
```
Create a Snowflake Task that runs every Monday at 9 AM and:
1. Calculates total sales for the previous week
2. Identifies top 3 performing products
3. Sends an email summary using the send_email procedure
```

**Test the email:**
```
Test the send_email procedure by sending a sample sales report to my email
```

---

## Cleanup

When you're done with the lab, clean up all created objects.

#### Manual Path

1. Open `scripts/06_cleanup.sql`
2. Review the DROP statements (this is permanent!)
3. Run all statements

#### Cortex Code Path

```
Run scripts/06_cleanup.sql to remove all lab objects
```

> **Warning**: This permanently deletes all databases, tables, and data created in this lab!

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| "Insufficient privileges" | Ensure you're using `ACCOUNTADMIN` role for Step 1 |
| "Warehouse does not exist" | Run Step 1 first to create the warehouse |
| "Table does not exist" | Run steps in order: 1 → 2 → 3 → 4 → 5 |
| "Cannot create agent" | Verify `snowflake_intelligence.agents` schema exists |
| Email not sending | Check notification integration permissions |

### Getting Help

- [Snowflake Documentation](https://docs.snowflake.com)
- [Snowflake Intelligence Guide](https://quickstarts.snowflake.com/guide/getting-started-with-snowflake-intelligence/index.html)
- [Cortex Code Help](https://docs.snowflake.com/en/user-guide/snowflake-cortex/cortex-code)

---

## Summary

Congratulations! You've completed the Snowflake Intelligence lab. You learned how to:

- Set up the infrastructure for AI-powered analytics
- Load and organize retail data
- Create a semantic model that describes your data
- Build an AI agent that answers natural language questions
- (Bonus) Use Cortex AI for sentiment analysis, build dashboards, and automate reports

### Next Steps

- Explore adding more data sources to your semantic model
- Create agents for other business domains
- Integrate agents with your existing workflows
