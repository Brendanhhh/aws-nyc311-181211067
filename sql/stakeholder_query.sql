-- Stakeholder Question: Which agencies have the highest and lowest success rates for resolving 311 complaints within 3 days?
-- This query calculates the percentage of complaints resolved in <= 3 days per agency.

SELECT 
    agency,
    COUNT(*) as total_complaints,
    SUM(CASE 
        WHEN closed_date <> '' 
         AND date_diff('day', date_parse(created_date, '%Y-%m-%d %H:%i:%s'), date_parse(closed_date,  '%Y-%m-%d %H:%i:%s')) <= 3 
        THEN 1 ELSE 0 
    END) as fast_resolutions,
    CAST(SUM(CASE 
        WHEN closed_date <> '' 
         AND date_diff('day', date_parse(created_date, '%Y-%m-%d %H:%i:%s'), date_parse(closed_date,  '%Y-%m-%d %H:%i:%s')) <= 3 
        THEN 1 ELSE 0 
    END) AS DOUBLE) / COUNT(*) * 100 AS percent_resolved_in_3_days
FROM nyc311_db.complaints
GROUP BY agency
ORDER BY percent_resolved_in_3_days ASC;