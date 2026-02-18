# Getting Started with Snowflake Intelligence

A hands-on lab for building AI-powered agents with Snowflake Intelligence.

## Choose Your Path

| Path | Guide | Time | Naming | Description |
|------|-------|------|--------|-------------|
| **Manual** | [LAB_GUIDE_MANUAL.md](LAB_GUIDE_MANUAL.md) | ~45 min | `si_*` | Copy/paste SQL scripts into Snowsight |
| **Cortex Code** | [LAB_GUIDE_CORTEX_CODE.md](LAB_GUIDE_CORTEX_CODE.md) | ~25 min | `coco_*` | Goal-based prompts, AI generates solutions |

### Run Both in Parallel

The two paths use different naming conventions (`si_*` vs `coco_*`), so you can run both simultaneously and compare:
- How Cortex Code generates SQL vs hand-written scripts
- Semantic model differences (synonyms, descriptions)
- Agent response quality

## What's Included

```
├── LAB_GUIDE_MANUAL.md        # Step-by-step SQL scripts
├── LAB_GUIDE_CORTEX_CODE.md   # Goal-based AI prompts + bonus tracks
├── scripts/                    # SQL scripts (Manual path only)
│   ├── 01_setup_roles_warehouse.sql
│   ├── 02_create_tables.sql
│   ├── 03_load_data.sql
│   ├── 04a_semantic_model_git.sql
│   ├── 04b_semantic_model_manual.sql
│   ├── 05_email_integration.sql
│   ├── 06_cortex_search_setup.sql
│   └── 07_cleanup.sql
├── notebooks/                  # Jupyter notebooks
│   └── sales_forecast_model.ipynb  # ML model training (bonus track)
├── marketing_campaigns.yaml    # Semantic model (Manual path)
└── data/                       # Sample CSV files
```

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` access
- For Cortex Code path: Cortex Code CLI installed

## Lab Overview

| Step | Description |
|------|-------------|
| 1 | Setup roles, warehouse & databases |
| 2 | Create tables for retail analytics |
| 3 | Load data from S3 |
| 4 | Create/generate semantic model |
| 5 | Email integration (optional) |
| 6 | Cortex Search service for support trends |
| 7 | Create AI agent |
| 8 | Add Cortex Search to agent |
| 9 | Test with natural language queries |

**Bonus tracks** (both paths): ML sales forecasting with Snowpark ML/XGBoost, sentiment analysis, Streamlit dashboards, semantic model extensions, automated reports.

## Resources

- [Snowflake Intelligence Documentation](https://docs.snowflake.com)
- [Cortex Code Documentation](https://docs.snowflake.com/en/user-guide/snowflake-cortex/cortex-code)
- [Original QuickStart](https://quickstarts.snowflake.com/guide/getting-started-with-snowflake-intelligence/index.html)

## Cleanup

- **Manual path:** Run `scripts/07_cleanup.sql`
- **Cortex Code path:** Ask Cortex Code to drop all `coco_*` objects
