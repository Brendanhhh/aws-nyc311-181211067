-- BUG IDENTIFIED: The original query crashes because `closed_date` contains empty strings for unresolved issues.
-- FIX: Added a WHERE clause (`WHERE closed_date <> ''`) to filter out open complaints before parsing the dates.

SELECT
  agency,
  AVG(
    date_diff(
      'day',
      date_parse(created_date, '%Y-%m-%d %H:%i:%s'),
      date_parse(closed_date,  '%Y-%m-%d %H:%i:%s')
    )
  ) AS avg_days_to_close
FROM nyc311_db.complaints
WHERE closed_date <> ''
GROUP BY agency
ORDER BY avg_days_to_close DESC;