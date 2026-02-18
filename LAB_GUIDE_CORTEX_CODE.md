# Getting Started with Snowflake Intelligence - Cortex Code Path

## Overview

In this hands-on lab, you'll use **Cortex Code** to build a Snowflake Intelligence agent using natural language prompts. Instead of running pre-written SQL scripts, you'll describe what you need and let Cortex Code generate the solutions.

This approach demonstrates how Cortex Code can:
- Understand requirements and generate appropriate SQL
- Create database objects from descriptions
- Build semantic models from table structures
- Reason through complex multi-step tasks

### What You'll Build

A complete retail analytics environment with:
- Infrastructure (role, warehouse, databases)
- Data tables loaded from S3
- A semantic model for natural language queries
- A Cortex Search service for support case insights
- An AI agent that answers business questions

### Time to Complete

~25 minutes (+ bonus tracks)

### Parallel Execution

This path uses **`coco_*`** naming for all objects, so you can run it alongside the Manual path (which uses `si_*` naming) and compare results.

---

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` role access
- Cortex Code CLI installed and connected to your account

### Verify Your Setup

```bash
cortex connections list
```

You should see your Snowflake connection listed.

---

## Lab Steps

For each step, copy the prompt into Cortex Code and observe how it reasons through the solution.

---

### Step 1: Create Infrastructure

**Goal:** Set up the foundational Snowflake objects for a retail analytics lab.

**Prompt:**
```
I need to set up Snowflake infrastructure for a retail analytics lab. Please create:

1. A role called "coco_admin" with permissions to create warehouses, databases, and integrations
2. A LARGE warehouse called "coco_wh"
3. A database called "coco_db" with a schema called "retail"
4. A database called "coco_agents_db" with a schema called "agents" for storing Snowflake Intelligence agents

Grant the role to my current user and grant CREATE AGENT permission on the agents schema.
```

**What to observe:** Watch how Cortex Code generates the SQL with proper grant statements and role switching.

**Verification prompt:**
```
Show me all databases and warehouses that start with "coco"
```

---

### Step 2: Create Tables

**Goal:** Create tables to store retail analytics data.

**Prompt:**
```
In the coco_db.retail schema, create tables for retail analytics:

1. marketing_campaign_metrics - to track ad campaigns with columns: date, category, campaign_name, impressions (integer), clicks (integer)

2. products - product catalog with: product_id (integer), product_name, category

3. sales - transactions with: date, region, product_id (integer), units_sold (integer), sales_amount (decimal)

4. social_media - social mentions with: date, category, platform, influencer, mentions (integer)

5. support_cases - customer tickets with: id, title, product, transcript (long text), date

Also create a CSV file format called "coco_csvformat" that skips the header row.
```

**What to observe:** Notice how Cortex Code infers appropriate data types and creates all objects.

**Verification prompt:**
```
List all tables in coco_db.retail and show their column counts
```

---

### Step 3: Load Data from S3

**Goal:** Load sample retail data from a public S3 bucket.

**Prompt:**
```
Load data into the coco_db.retail tables from this S3 bucket:
s3://sfquickstarts/sfguide_getting_started_with_snowflake_intelligence/

The bucket has these subfolders:
- marketing/ → marketing_campaign_metrics table
- product/ → products table
- sales/ → sales table
- social_media/ → social_media table
- support/ → support_cases table

Create the necessary stages and load the data. Use the coco_csvformat file format.
```

**What to observe:** See how Cortex Code creates stages with proper URLs and executes COPY commands.

**Verification prompt:**
```
Show me the row count for each table in coco_db.retail
```

**Expected results:** ~30 marketing records, ~30 products, ~5,000 sales, ~200 social media, ~500 support cases.

---

### Step 4: Create Semantic Model

**Goal:** Create a semantic model that describes the data relationships and enables natural language queries.

**Prompt:**
```
Create a semantic model YAML file for the tables in coco_db.retail. The model should:

1. Define all 4 main tables (marketing_campaign_metrics, products, sales, social_media) with their columns as dimensions, facts, and time_dimensions

2. Add helpful synonyms for each column (e.g., "revenue" for sales_amount, "clicks" could also be "click_throughs")

3. Define these relationships:
   - sales joins to products on product_id (many-to-one)
   - social_media joins to marketing_campaign_metrics on category (many-to-one)

4. Add one verified query example for: "Show me the trend of sales by product category between June 2025 and August 2025"

Name the model "Coco_Retail_Analytics" and save it to a stage called "semantic_models" in coco_db.retail.
```

**What to observe:** This is the key step - watch Cortex Code build a complete semantic model from the table structures.

**Verification prompt:**
```
List files in the @coco_db.retail.semantic_models stage
```

---

### Step 5: Email Integration (Optional)

**Goal:** Enable the agent to send email notifications.

**Prompt:**
```
Set up email notification capability in coco_db.retail:

1. Create a notification integration called "coco_email_integration" for email
2. Create a stored procedure called "send_email" that takes recipient_email, subject, and body parameters and uses SYSTEM$SEND_EMAIL to send HTML emails
3. Enable Cortex cross-region for AWS_US
```

> **Note:** Skip if you encounter permission errors.

---

### Step 6: Cortex Search Service

**Goal:** Create a searchable summary of support cases for trend analysis.

**Prompt:**
```
In coco_db.retail, create a Cortex Search service for support case insights:

1. First, use AI_AGG() on the support_cases.transcript column to create a comprehensive summary of all support cases (at least 5000 words). Store this in a table called "support_trends_summary"

2. Then create a Cortex Search service called "support_trends" on this summary table using the snowflake-arctic-embed-m-v1.5 embedding model with a 1-hour target lag

This will let the agent answer questions about overall support trends.
```

> **Note:** This step takes 3-5 minutes due to AI processing.

**Verification prompt:**
```
Show Cortex Search services in coco_db.retail
```

---

### Step 7: Create the Agent

**Goal:** Create a Snowflake Intelligence agent using the semantic model.

**Prompt:**
```
Help me create a Snowflake Intelligence agent:
- Name: "Coco Retail Agent"
- Use the semantic model from @coco_db.retail.semantic_models
- Use warehouse coco_wh
- Store it in coco_agents_db.agents schema
```

---

### Step 8: Add Cortex Search to Agent

**Goal:** Add the Cortex Search service as a tool so the agent can answer questions about support trends.

**Prompt:**
```
Add the Cortex Search service "support_trends" from coco_db.retail to the Coco Retail Agent as a tool.

The tool should be named "Support Trends" and described as "Search aggregated support case trends and common issues"

This will allow the agent to answer questions about customer support patterns.
```

**What to observe:** Watch how Cortex Code configures the agent to use multiple data sources (semantic model + Cortex Search).

---

### Step 9: Test Your Agent

Try these prompts to test the agent:

**Structured data queries (via Semantic Model):**
```
Ask the Coco Retail Agent: What were total sales by region?
```

```
Ask the agent: Which product categories generate the most revenue?
```

**Trend analysis:**
```
Ask the agent: Show me the trend of sales by product category between June 2025 and August 2025
```

**Marketing insights:**
```
Ask the agent: Which marketing campaigns had the best click-through rate?
```

**Support trends (via Cortex Search):**
```
Ask the agent: What are the most common customer support issues?
```

```
Ask the agent: Summarize the main themes from support cases
```

---

## Bonus Tracks

### Bonus 1: Sentiment Analysis

```
Using Cortex COMPLETE, analyze the support_cases transcripts in coco_db.retail. 
Classify each case as positive, negative, or neutral sentiment.
Store results in a new table called "support_sentiment" with columns: case_id, sentiment, confidence_score.
```

### Bonus 2: Build a Dashboard

```
Create a Streamlit app for coco_db.retail data that shows:
1. Sales by region (bar chart)
2. Sales trend over time (line chart)
3. Top 10 products by revenue
4. Interactive filters for date range and category
```

### Bonus 3: Extend the Semantic Model

```
Add a calculated metric for Click-Through Rate (CTR) to the semantic model.
CTR = (clicks / impressions) * 100
Update the YAML and re-upload to the stage.
```

### Bonus 4: Automated Reports

```
Create a Snowflake Task that runs weekly and:
1. Calculates total sales for the previous week
2. Finds the top 3 products
3. Sends a summary email using the send_email procedure
```

---

## Cleanup

When you're done, remove all objects created:

**Prompt:**
```
Clean up the Cortex Code lab by dropping:
- Databases: coco_db, coco_agents_db
- Warehouse: coco_wh
- Integrations: coco_email_integration
- Role: coco_admin

Use ACCOUNTADMIN role and drop in the correct order.
```

> **Warning:** This permanently deletes all data!

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Connection not found" | Run `cortex connections list` and verify connection |
| "Insufficient privileges" | Ensure connection uses `ACCOUNTADMIN` role |
| "Object does not exist" | Run steps in order - each builds on previous |
| "Semantic model validation failed" | Ask Cortex Code to validate and fix the YAML |
| "Cortex Search failed" | Ensure warehouse is running with sufficient size |

---

## Summary

You've completed the lab using Cortex Code! You experienced how it can:

- Generate infrastructure SQL from requirements
- Create and load database objects
- Build semantic models from table structures
- Set up AI-powered search services
- Create and configure agents

### Comparing Paths

If you also ran the Manual path, compare:
- **SQL generated** - How does Cortex Code's SQL compare to the scripts?
- **Semantic model** - Are the synonyms and descriptions different?
- **Agent responses** - Do both agents give similar answers?

### Next Steps

- Try more complex prompts to see Cortex Code's reasoning
- Build agents for your own data
- Explore advanced Cortex AI features (summarization, classification, extraction)
