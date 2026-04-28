## Query: Average resolution time by agency
- **File:** sql/resolution_time.sql
- **Business question:** How long does each agency take to resolve complaints?
- **What I expected:** A descending list of agencies and the average number of days it takes them to close a ticket.
- **Issues encountered:** The query threw an error regarding `date_parse`. 
- **Checks performed:** I checked the data dictionary and raw data, realizing that open complaints have an empty string `""` for `closed_date`. The `date_parse` function cannot parse an empty string.
- **Final outcome:** I added `WHERE closed_date <> ''` to the query to exclude unresolved complaints. The query now successfully calculates the average resolution time for closed tickets.
- **Confidence:** High. Would present to stakeholder.