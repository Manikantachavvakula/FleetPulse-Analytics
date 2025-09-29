-- ANALYSIS 2: MOST EXPENSIVE FAILURE TYPES
-- Identifies top 3 systems for predictive maintenance focus
SELECT 
    'MAINTENANCE: ' || maintenance_type as issue_type,
    COUNT(*) as frequency,
    ROUND(AVG(cost_usd)) as avg_cost,
    ROUND(AVG(downtime_days)) as avg_downtime,
    ROUND(SUM(cost_usd)) as total_cost
FROM maintenance
GROUP BY maintenance_type

UNION ALL

SELECT 
    'BREAKDOWN: ' || issue_category as issue_type,
    COUNT(*) as frequency,
    ROUND(AVG(repair_cost_usd)) as avg_cost,
    ROUND(AVG(downtime_days)) as avg_downtime,
    ROUND(SUM(repair_cost_usd)) as total_cost
FROM breakdowns
GROUP BY issue_category

ORDER BY total_cost DESC
LIMIT 10;