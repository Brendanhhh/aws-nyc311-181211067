* **Query Checked:** sql/resolution_time.sql
* **Issue Encountered:** The date_diff function originally failed because created_date and closed_date were strings.
* **Refinement:** Used date_parse() to convert strings to timestamps for Athena arithmetic.
* **Outcome:** The query now correctly outputs average resolution days per agency.
