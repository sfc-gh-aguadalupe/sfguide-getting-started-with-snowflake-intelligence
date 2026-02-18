# Getting Started with Snowflake Intelligence - Manual Path

## Overview

In this hands-on lab, you'll learn how to use **Snowflake Intelligence** to create AI-powered agents that can answer business questions using natural language. You'll work with a retail analytics dataset including sales, marketing campaigns, social media, and customer support data.

### What You'll Learn

- Set up infrastructure for Snowflake Intelligence
- Load and organize retail analytics data
- Create and configure a semantic model
- Build an AI agent that answers business questions

### Time to Complete

~45 minutes

---

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` role access
- Access to Snowsight (Snowflake's web UI)

### Verify Your Setup

Log into Snowsight and ensure you can:
1. Access a SQL worksheet
2. See the ACCOUNTADMIN role in your role selector

---

## Lab Steps

### Step 1: Setup Roles, Warehouse & Databases

This step creates the foundational infrastructure for the lab.

**Objects Created:**
- Role: `si_admin`
- Warehouse: `si_wh`
- Databases: `si_db`, `si_agents_db`
- Schemas: `retail`, `agents`

**Instructions:**

1. Open a new worksheet in Snowsight
2. Copy and paste the contents of `scripts/01_setup_roles_warehouse.sql`
3. Run all statements (Ctrl+Enter or Cmd+Enter)
4. Verify you see: "Step 1 Complete: Roles, warehouse, and databases created successfully!"

**Verification:**

```sql
SHOW DATABASES LIKE 'si_%';
SHOW WAREHOUSES LIKE 'si_%';
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

**Instructions:**

1. Open `scripts/02_create_tables.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements

**Verification:**

```sql
SHOW TABLES IN si_db.retail;
```

You should see 5 tables listed.

---

### Step 3: Load Data

This step loads sample data from S3 into the tables.

**Instructions:**

1. Open `scripts/03_load_data.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements
4. Review the row counts in the output

**Verification:**

```sql
SELECT 'marketing_campaign_metrics' AS table_name, COUNT(*) AS rows FROM si_db.retail.marketing_campaign_metrics
UNION ALL SELECT 'products', COUNT(*) FROM si_db.retail.products
UNION ALL SELECT 'sales', COUNT(*) FROM si_db.retail.sales
UNION ALL SELECT 'social_media', COUNT(*) FROM si_db.retail.social_media
UNION ALL SELECT 'support_cases', COUNT(*) FROM si_db.retail.support_cases;
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

**Choose one option:**

#### Option A: Git Integration (Recommended)

Use this if your account supports Git integration.

1. Open `scripts/04a_semantic_model_git.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements
4. Verify the YAML file appears in the stage listing

#### Option B: Manual Upload

Use this if Git integration is not available or you prefer manual control.

1. Open `scripts/04b_semantic_model_manual.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements to create the stage
4. Upload the semantic model file:
   - Navigate to **Data > Databases > SI_DB > RETAIL > Stages**
   - Click on **SEMANTIC_MODELS** stage
   - Click **+ Files** button
   - Select `marketing_campaigns.yaml` from this repo
   - Click **Upload**

**Verification:**

```sql
LIST @si_db.retail.semantic_models;
```

You should see `marketing_campaigns.yaml` in the listing.

---

### Step 5: Email Integration (Optional)

This step enables agents to send email notifications.

**Instructions:**

1. Open `scripts/05_email_integration.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements

> **Note**: Email functionality requires additional account setup. Skip this step if you encounter permission errors.

---

### Step 6: Cortex Search Service Setup

This step creates an aggregated support cases summary using Cortex AI and sets up a Cortex Search service. This enables the agent to answer questions based on high-level trends from support tickets.

**Objects Created:**
| Object | Type | Description |
|--------|------|-------------|
| `aggregated_support_cases_summary` | Table | AI-generated summary of all support cases |
| `aggregated_support_cases` | Cortex Search Service | Searchable index on the summary |

> **Note**: This step may take **3-5 minutes** to complete due to AI processing.

**Instructions:**

1. Open `scripts/06_cortex_search_setup.sql`
2. Copy and paste into your Snowsight worksheet
3. Run all statements
4. Wait for completion (3-5 minutes)

**Verification:**

```sql
SHOW CORTEX SEARCH SERVICES IN si_db.retail;
```

You should see `aggregated_support_cases` listed.

---

### Step 7: Create the Snowflake Intelligence Agent

Now we'll create an AI agent that can answer questions about your retail data!

**Instructions:**

1. Navigate to **Snowflake Intelligence** in Snowsight (left sidebar)
2. Click **+ Create Agent**
3. Configure the agent:
   - **Name**: `Retail Analytics Agent`
   - **Semantic Model**: Select `@si_db.retail.semantic_models/marketing_campaigns.yaml`
   - **Warehouse**: `si_wh`
4. Click **Create**

---

### Step 8: Add Cortex Search Service to Agent

Now we'll add the Cortex Search service as a tool so the agent can answer questions about support case trends.

**Instructions:**

1. Open your agent in Snowsight (Snowflake Intelligence > Retail Analytics Agent)
2. Click **Edit** or **Configure**
3. Navigate to the **Tools** section
4. Click **+ Add Tool**
5. Select **Cortex Search** as the tool type
6. Configure the tool:
   - **Name**: `Support Trends`
   - **Cortex Search Service**: Select `si_db.retail.aggregated_support_cases`
   - **Description**: `Search aggregated support case trends and common issues`
7. Click **Save**

The agent can now answer questions about both structured data (via semantic model) and support trends (via Cortex Search).

---

### Step 9: Test Your Agent

Try asking your agent these questions:

**Structured data queries (via Semantic Model):**
1. **"What were total sales by region last month?"**
2. **"Which marketing campaigns had the highest click-through rate?"**
3. **"Show me the trend of sales by product category between June 2025 and August 2025"**
4. **"What are the top 5 products by revenue?"**

**Support trends queries (via Cortex Search):**
5. **"What are the most common customer support issues?"**
6. **"Summarize the main themes from support cases"**

---

## Bonus Tracks

### Bonus: ML Sales Forecasting Model (Optional)

Train an XGBoost model using Snowpark ML to predict sales amounts. The model can be added as a tool to your agent.

**What You'll Build:**
- XGBoost regression model trained on sales data
- Model registered in Snowflake Model Registry
- UDF for scoring that can be called by the agent

**Instructions:**

1. Navigate to **Notebooks** in Snowsight
2. Click **+ Notebook** → **Import from file**
3. Upload `notebooks/sales_forecast_model.ipynb` from this repo
4. **IMPORTANT:** In cell 2, verify these settings:
   ```python
   DATABASE = 'SI_DB'  # Keep as-is for Manual path
   MODEL_NAME = 'si_sales_forecast'  # Keep as-is for Manual path
   ```
5. Run all cells (this takes 2-3 minutes)
6. Verify the model is registered:
   ```sql
   SHOW MODELS IN SI_DB.RETAIL;
   ```

**Add the Model to Your Agent:**

1. Open your agent in Snowsight (Snowflake Intelligence > Retail Analytics Agent)
2. Click **Edit** or **Configure**
3. Navigate to the **Tools** section
4. Click **+ Add Tool**
5. Select **Function** as the tool type
6. Configure the tool:
   - **Function**: Select `SI_DB.RETAIL.PREDICT_SALES`
   - **Description**: `Predict sales amount given region, product category, month, and estimated units`
7. Click **Save**

**Test the ML Tool:**

Ask your agent:
- "Predict sales for West region, Fitness Wear category, for September with 75 units"
- "What would sales be for Electronics in the East region next month if we sell 100 units?"

---

## Cleanup

When you're done with the lab, clean up all created objects.

**Instructions:**

1. Open `scripts/07_cleanup.sql`
2. Review the DROP statements (this is permanent!)
3. Run all statements

> **Warning**: This permanently deletes all databases, tables, and data created in this lab!

---

## Troubleshooting

### Common Issues

| Issue | Solution |
|-------|----------|
| "Insufficient privileges" | Ensure you're using `ACCOUNTADMIN` role for Step 1 |
| "Warehouse does not exist" | Run Step 1 first to create the warehouse |
| "Table does not exist" | Run steps in order: 1 → 2 → 3 → 4 → 5 → 6 |
| "Cannot create agent" | Verify `si_agents_db.agents` schema exists |
| "Cortex Search service failed" | Ensure warehouse is running and has sufficient size |
| "Git integration failed" | Use Option B (manual upload) for Step 4 |
| Email not sending | Check notification integration permissions |

### Getting Help

- [Snowflake Documentation](https://docs.snowflake.com)
- [Snowflake Intelligence Guide](https://quickstarts.snowflake.com/guide/getting-started-with-snowflake-intelligence/index.html)

---

## Summary

Congratulations! You've completed the Snowflake Intelligence lab. You learned how to:

- Set up the infrastructure for AI-powered analytics
- Load and organize retail data
- Create a semantic model that describes your data
- Build an AI agent that answers natural language questions

### Next Steps

- Explore adding more data sources to your semantic model
- Create agents for other business domains
- Integrate agents with your existing workflows
- Try the [Cortex Code path](LAB_GUIDE_CORTEX_CODE.md) for an AI-assisted experience
