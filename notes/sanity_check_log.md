## Technical Audit: Agency Resolution Latency
- **File:** sql/resolution_time.sql
- **Operational Objective:** Quantify average resolution time per agency to provide stakeholder visibility into service delivery performance.
- **Root Cause Analysis (RCA):** The initial date_parse operation failed due to an INVALID_FUNCTION_ARGUMENT. Technical discovery revealed that unresolved/open complaints are represented by empty strings ("") in the closed_date column. Athena's SQL engine cannot parse empty strings into timestamp formats, resulting in query termination.
- **Resolution Implementation:** Applied a logical filter (WHERE closed_date <> '') to exclude in-progress requests. This maintains data integrity by ensuring resolution metrics are calculated exclusively for completed service requests.
- **Validation Status:** High confidence. Query is verified for production stakeholder reporting.
