# Getting Started with Snowflake Intelligence

A hands-on lab for building AI-powered agents with Snowflake Intelligence.

## Quick Start

**Choose your path:**

| Path | Command/Action |
|------|----------------|
| **Manual** | Open [LAB_GUIDE.md](LAB_GUIDE.md) and follow the Manual instructions |
| **Cortex Code** | Open [LAB_GUIDE.md](LAB_GUIDE.md) and use the provided prompts |

## What's Included

```
├── LAB_GUIDE.md              # Step-by-step lab instructions
├── scripts/                   # Modular SQL scripts
│   ├── 01_setup_roles_warehouse.sql
│   ├── 02_create_tables.sql
│   ├── 03_load_data.sql
│   ├── 04_semantic_model_setup.sql
│   ├── 05_email_integration.sql
│   └── 06_cleanup.sql
├── marketing_campaigns.yaml   # Semantic model definition
└── data/                      # Sample CSV data files
```

## Prerequisites

- Snowflake account with `ACCOUNTADMIN` access
- (Optional) Cortex Code CLI for automated path

## Lab Overview

| Step | Description | Time |
|------|-------------|------|
| 1 | Setup roles, warehouse & databases | 5 min |
| 2 | Create tables | 2 min |
| 3 | Load data from S3 | 3 min |
| 4 | Setup semantic model | 5 min |
| 5 | Email integration (optional) | 3 min |
| 6 | Create AI agent | 10 min |
| 7 | Test your agent | 10 min |

**Bonus tracks** include: Cortex AI sentiment analysis, Streamlit dashboards, extending semantic models, and automated reports.

## Resources

- [Full Lab Guide](LAB_GUIDE.md)
- [Snowflake Intelligence Documentation](https://docs.snowflake.com)
- [Original QuickStart](https://quickstarts.snowflake.com/guide/getting-started-with-snowflake-intelligence/index.html)

## Cleanup

Run `scripts/06_cleanup.sql` to remove all lab objects when finished.
