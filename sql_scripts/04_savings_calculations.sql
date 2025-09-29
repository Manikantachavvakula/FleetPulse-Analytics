-- FLEETPULSE ANALYTICS - SAVINGS CALCULATIONS
-- ROI and business case calculations for executive presentation

-- SAVINGS CALCULATION 1: Total Potential Savings
-- Calculates the $2.1M Year 1 savings opportunity
WITH cost_analysis AS (
    SELECT 
        -- Current emergency maintenance that could be planned
        (SELECT SUM(cost_usd) FROM maintenance WHERE maintenance_type = 'Emergency') as current_emergency_cost,
        
        -- What it would cost as scheduled maintenance (60% less)
        (SELECT SUM(cost_usd) * 0.4 FROM maintenance WHERE maintenance_type = 'Emergency') as potential_scheduled_cost,
        
        -- Current breakdown costs that could be prevented
        (SELECT SUM(repair_cost_usd) FROM breakdowns) as current_breakdown_cost,
        
        -- Delivery penalties from breakdowns
        (SELECT SUM(penalty_fees_usd) FROM deliveries WHERE was_delayed = true) as penalty_costs
)
SELECT 
    current_emergency_cost,
    potential_scheduled_cost,
    current_breakdown_cost,
    penalty_costs,
    ROUND(current_emergency_cost - potential_scheduled_cost) as emergency_savings,
    ROUND(current_breakdown_cost * 0.7) as breakdown_savings, -- 70% preventable
    ROUND(penalty_costs * 0.8) as penalty_savings, -- 80% preventable
    ROUND((current_emergency_cost - potential_scheduled_cost) + 
          (current_breakdown_cost * 0.7) + 
          (penalty_costs * 0.8)) as total_potential_savings
FROM cost_analysis;

-- SAVINGS CALCULATION 2: Focus on Top 3 Failure Types
-- Shows savings potential from targeting Electrical, Tires, Transmission
SELECT 
    issue_category,
    SUM(repair_cost_usd) as total_repair_cost,
    AVG(downtime_days) as avg_downtime,
    ROUND(SUM(repair_cost_usd) * 0.7) as potential_savings -- 70% preventable
FROM breakdowns
WHERE issue_category IN ('Electrical', 'Tires', 'Transmission')
GROUP BY issue_category
ORDER BY total_repair_cost DESC;

-- ROI CALCULATION: Business case justification
-- Implementation cost: $500K, Year 1 savings: $2.1M
SELECT 
    500000 as implementation_cost,
    2100000 as year1_savings,
    ROUND(2100000 / 500000 * 100) as roi_percentage,
    ROUND(500000 / (2100000/12)) as payback_months;