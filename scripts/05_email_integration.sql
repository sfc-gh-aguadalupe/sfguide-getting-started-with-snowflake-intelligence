-- ============================================================================
-- STEP 5: Email Integration Setup
-- ============================================================================
-- This script creates an email notification integration and a stored procedure
-- that can be used by agents to send email notifications.
-- ============================================================================

USE ROLE si_admin;
USE DATABASE si_db;
USE SCHEMA retail;
USE WAREHOUSE si_wh;

-- Create email notification integration
CREATE OR REPLACE NOTIFICATION INTEGRATION si_email_integration
    TYPE = EMAIL
    ENABLED = TRUE
    DEFAULT_SUBJECT = 'Snowflake Intelligence';

-- Create stored procedure for sending emails
CREATE OR REPLACE PROCEDURE send_email(
    recipient_email VARCHAR,
    subject VARCHAR,
    body VARCHAR
)
RETURNS VARCHAR
LANGUAGE PYTHON
RUNTIME_VERSION = '3.12'
PACKAGES = ('snowflake-snowpark-python')
HANDLER = 'send_email'
AS
$$
def send_email(session, recipient_email, subject, body):
    try:
        # Escape single quotes in the body
        escaped_body = body.replace("'", "''")
        
        # Execute the system procedure call
        session.sql(f"""
            CALL SYSTEM$SEND_EMAIL(
                'si_email_integration',
                '{recipient_email}',
                '{subject}',
                '{escaped_body}',
                'text/html'
            )
        """).collect()
        
        return "Email sent successfully"
    except Exception as e:
        return f"Error sending email: {str(e)}"
$$;

-- Enable Cortex cross-region (required for some AI features)
ALTER ACCOUNT SET CORTEX_ENABLED_CROSS_REGION = 'AWS_US';

SELECT 'Step 5 Complete: Email integration and Cortex enabled!' AS status;
