-- FLEETPULSE ANALYTICS - DATA CLEANING
-- Fixing data quality issues discovered during analysis

-- DATA QUALITY CHECK: Verify initial data state
SELECT 
    'Maintenance' as table_name,
    COUNT(*) as total_rows,
    SUM(CASE WHEN truck_id IS NULL THEN 1 ELSE 0 END) as missing_truck_ids,
    SUM(CASE WHEN cost_usd IS NULL THEN 1 ELSE 0 END) as missing_costs,
    SUM(CASE WHEN cost_usd <= 0 THEN 1 ELSE 0 END) as invalid_costs
FROM maintenance;

-- CRITICAL FIX: Correct decimal point errors in maintenance costs
-- Found during analysis: Costs had extra zeros (e.g., $26,190 should be $2,619)
UPDATE maintenance SET cost_usd = 2366.5 WHERE maintenance_id = 'M0290';
UPDATE maintenance SET cost_usd = 2156.1 WHERE maintenance_id IN ('M0564', 'M0715');
UPDATE maintenance SET cost_usd = 2619.0 WHERE maintenance_id = 'M0992';
UPDATE maintenance SET cost_usd = 2312.5 WHERE maintenance_id = 'M1005';

-- VERIFICATION: Check the fixes worked
SELECT maintenance_id, cost_usd 
FROM maintenance 
WHERE maintenance_id IN ('M0290', 'M0564', 'M0715', 'M0992', 'M1005');

-- CHECK FOR OUTLIERS: Identify extremely high costs
SELECT 
    MIN(cost_usd) as min_cost,
    MAX(cost_usd) as max_cost,
    AVG(cost_usd) as avg_cost,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY cost_usd) as percentile_95
FROM maintenance;