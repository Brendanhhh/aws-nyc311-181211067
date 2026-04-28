SELECT COUNT(*) AS n_complaints
FROM nyc311_db.complaints;
 -- You should see a count of complaints in the dataset. The expected result is 200033.

SELECT 
  MIN(created_date) AS earliest,
  MAX(created_date) AS latest
FROM nyc311_db.complaints;

-- You should see the earliest and latest created_date in the dataset.


SELECT agency, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY agency
ORDER BY n DESC
LIMIT 10;

-- You should see the top 10 agencies with the most complaints. The expected result is: NPYD, HPD, DSNY etc..

SELECT borough, problem, COUNT(*) AS n
FROM nyc311_db.complaints
GROUP BY borough, problem
ORDER BY n DESC
LIMIT 20;

-- You should see the top 20 combinations of borough and problem. The expected result is: Brooklyn, Illegal Parking. Bronx, Heat/Water etc..

-- This query joins the complaints and agencies tables to show the number of complaints by full agency name.
SELECT 
  c.agency,
  a.agency_name,
  COUNT(*) AS n
FROM nyc311_db.complaints AS c
JOIN nyc311_db.agencies AS a
  ON c.agency = a.agency
GROUP BY c.agency, a.agency_name
ORDER BY n DESC;