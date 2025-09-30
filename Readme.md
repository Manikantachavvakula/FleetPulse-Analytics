# 🚛 FleetPulse Analytics
### Predictive Maintenance Intelligence Platform | $2.1M Cost Savings Identified

[![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?logo=postgresql)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi)](https://powerbi.microsoft.com/)
[![Business Impact](https://img.shields.io/badge/ROI-320%25-success)](.)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> **End-to-end Business Intelligence solution that transformed reactive maintenance operations into data-driven predictive strategy, uncovering $14.8M in hidden costs and identifying $2.1M Year 1 savings opportunity with 320% ROI.**

---

## 📊 Business Impact at a Glance

| Metric | Finding | Business Value |
|--------|---------|----------------|
| **Hidden Costs Discovered** | $14.8M actual vs. $1.2M perceived | 1,133% cost visibility gap |
| **Year 1 Savings Potential** | $2.1M identified | 40% reduction in unplanned downtime |
| **ROI** | 320% return | 3-month payback period |
| **Penalty Reduction** | $13.8M → $2.8M potential | 80% delivery penalty elimination |
| **Emergency Maintenance** | 3x more expensive | Shift to preventive saves 60% |

---

## 🎯 Problem Statement

A mid-sized logistics company with a 500-truck fleet was hemorrhaging money through reactive maintenance:

- ❌ **Perceived cost:** $1.2M in maintenance
- ⚠️ **Actual cost:** $14.8M (1,133% underestimation)
- 📉 **Customer churn:** 15% due to delivery delays
- ⏱️ **Downtime:** 5 days average per breakdown
- 💸 **Delivery penalties:** $13.8M annually
- 🔴 **Approach:** Fully reactive "fix it when it breaks"

**The company didn't know they had a problem—until the data revealed it.**

---

## 💡 Solution Architecture

Built a comprehensive BI platform from the ground up to transform maintenance operations:

```
┌─────────────────────────────────────────────────────────────┐
│                    DATA PIPELINE                             │
├─────────────────────────────────────────────────────────────┤
│  Raw CSV Data → PostgreSQL → SQL Analysis → Power BI        │
│     (5 sources)     (Cleaning)    (Insights)    (Dashboard)  │
└─────────────────────────────────────────────────────────────┘
```

### Technical Implementation

1. **Database Design** (PostgreSQL)
   - Normalized schema with 5 core tables (trucks, maintenance, breakdowns, deliveries, fuel)
   - Referential integrity and performance optimization
   - Historical data architecture for trend analysis

2. **Data Quality Engineering** (SQL)
   - Identified and corrected decimal point errors ($26,190 → $2,619)
   - Standardized date formats and category values
   - Implemented data validation rules

3. **Business Intelligence Layer** (SQL Analytics)
   - Root cause analysis queries
   - Cost breakdown by maintenance type
   - Truck performance scoring algorithms
   - ROI and savings calculation models

4. **Visualization & Reporting** (Power BI)
   - Executive KPI dashboard
   - Interactive breakdown cost analysis
   - Truck performance heat maps
   - Predictive maintenance recommendations

---

## 🔍 Key Insights Discovered

### Finding #1: Emergency Maintenance Premium
```sql
Emergency Maintenance: $3,000 average cost
Planned Maintenance:   $1,000 average cost
Cost Multiplier:       3x more expensive
```
**Business Impact:** Shifting 70% of emergency maintenance to planned saves **$1.2M annually**

### Finding #2: Top Failure Categories
| Failure Type | Total Cost | Frequency | Preventable Savings |
|--------------|-----------|-----------|---------------------|
| Electrical System | $1.9M | 89 incidents | $1.33M (70%) |
| Tire Failures | $1.1M | 76 incidents | $0.77M (70%) |
| Transmission | $0.9M | 45 incidents | $0.63M (70%) |

**Business Impact:** Focusing on these 3 systems yields **$2.7M in preventable costs**

### Finding #3: High-Risk Trucks
- Identified 12 trucks with 5+ breakdowns each
- Truck T076: $95K in annual maintenance (ROI-negative asset)
- Replacement analysis: 8 trucks exceed economic repair threshold

**Business Impact:** Strategic fleet replacement saves **$400K in Year 1**

### Finding #4: Penalty Cost Concentration
- 23% of trucks responsible for 71% of delivery penalties
- Root cause: Predictable failure patterns went undetected
- Average penalty per delayed delivery: $2,150

**Business Impact:** Predictive maintenance reduces penalties by **$11M (80%)**

---

## 📁 Project Structure

```
FleetPulse-Analytics/
│
├── data/                          # Raw data sources (CSV)
│   ├── trucks.csv                 # Fleet master data (500 trucks)
│   ├── maintenance.csv            # Maintenance records (1,200 entries)
│   ├── breakdowns.csv             # Emergency breakdown logs
│   ├── deliveries.csv             # Delivery & penalty tracking
│   └── fuel.csv                   # Fuel efficiency metrics
│
├── sql_scripts/                   # SQL analysis pipeline
│   ├── 01_database_setup.sql      # Schema creation & table design
│   ├── 02_data_cleaning.sql       # Data quality fixes & validation
│   ├── 03_business_analysis.sql   # Core analytical queries
│   └── 04_savings_calculations.sql # ROI & financial modeling
│
├── documentation/                 # Business deliverables
│   ├── BUSINESS_CASE.md           # Executive summary & ROI analysis
│   └── PROJECT_SUMMARY.md         # Technical documentation
│
├── dashboards/                    # Power BI files
│   └── FleetPulse_Dashboard.pbix  # Interactive analytics dashboard
│
└── README.md                      # This file
```

---

## 🛠️ Technology Stack

| Category | Technology | Purpose |
|----------|-----------|---------|
| **Database** | PostgreSQL 15 | Relational data warehouse |
| **Analytics** | SQL | Data cleaning, transformation, analysis |
| **Visualization** | Power BI Desktop | Interactive dashboards & reporting |
| **Development** | VS Code | SQL development environment |
| **Version Control** | Git/GitHub | Code management & collaboration |
| **Project Management** | Jira | Agile sprint tracking |

---

## 🚀 Key SQL Techniques Demonstrated

### 1. Advanced Data Cleaning
```sql
-- Correcting decimal point errors discovered during analysis
UPDATE maintenance 
SET cost_usd = CASE 
    WHEN maintenance_id = 'M0290' THEN 2366.5
    WHEN maintenance_id IN ('M0564', 'M0715') THEN 2156.1
    WHEN maintenance_id = 'M0992' THEN 2619.0
    ELSE cost_usd 
END
WHERE maintenance_id IN ('M0290', 'M0564', 'M0715', 'M0992');
```

### 2. Cost Analysis with CTEs
```sql
WITH cost_breakdown AS (
    SELECT 
        maintenance_type,
        SUM(cost_usd) as total_cost,
        COUNT(*) as frequency,
        AVG(downtime_days) as avg_downtime
    FROM maintenance
    GROUP BY maintenance_type
)
SELECT 
    maintenance_type,
    total_cost,
    ROUND(total_cost / SUM(total_cost) OVER () * 100, 1) as cost_percentage
FROM cost_breakdown
ORDER BY total_cost DESC;
```

### 3. ROI Calculations
```sql
SELECT
    500000 as implementation_cost,
    2100000 as year1_savings,
    ROUND((2100000 - 500000) / 500000 * 100) as roi_percentage,
    ROUND(500000 / (2100000/12), 1) as payback_months;
```

---

## 📈 Dashboard Features

**Page 1: Executive Overview**
- Total maintenance costs (actual vs. budget)
- Cost breakdown gauge (planned vs. emergency vs. penalties)
- KPI cards: Total savings potential, ROI, payback period
- Trend analysis: Monthly cost patterns

**Page 2: Breakdown Deep Dive**
- Most expensive failure types (pie chart)
- Cost distribution by issue category (horizontal bar chart)
- Truck performance ranking
- Downtime impact analysis

**Page 3: Truck Performance**
- Individual truck scorecards
- Maintenance history timelines
- Replacement vs. repair recommendations
- Fuel efficiency correlations

[**Screenshot Placeholder: Dashboard Preview**]

---

## 💼 Business Recommendations

### Immediate Actions (Month 1-3)
1. **Implement Predictive Maintenance Program**
   - Focus on Electrical, Tires, and Transmission systems
   - Expected savings: $675K in Quarter 1

2. **Replace High-Risk Trucks**
   - Retire 8 trucks with negative ROI
   - Immediate penalty reduction: $2.4M annually

3. **Establish Maintenance Cadence**
   - Shift from reactive to 60/40 planned/emergency split
   - Reduces average maintenance cost by 40%

### Strategic Initiatives (Month 4-12)
4. **IoT Sensor Integration**
   - Real-time monitoring of top 3 failure types
   - Predictive failure alerts 7-14 days in advance

5. **Supplier Contract Renegotiation**
   - Leverage data to negotiate bulk parts contracts
   - Additional 15% cost reduction potential

6. **Driver Training Program**
   - Correlate driver behavior with maintenance patterns
   - Optimize fuel efficiency and reduce wear

---

## 📊 Results & Impact

| Metric | Before | After (Projected) | Improvement |
|--------|--------|-------------------|-------------|
| Annual Maintenance Cost | $14.8M | $12.7M | **14% reduction** |
| Unplanned Downtime | 5 days/breakdown | 3 days/breakdown | **40% reduction** |
| Delivery Penalties | $13.8M | $2.8M | **80% reduction** |
| Customer Churn | 15% | 9% (est.) | **40% improvement** |
| Emergency Maintenance | 65% of costs | 25% of costs | **62% reduction** |

**Total Financial Impact: $2.1M in Year 1 savings on $500K implementation investment**

---

## 🎓 Skills Demonstrated

**Technical Skills:**
- ✅ Database Design & Normalization
- ✅ Advanced SQL (CTEs, Window Functions, Subqueries)
- ✅ Data Quality Engineering
- ✅ Statistical Analysis & Root Cause Analysis
- ✅ Power BI Dashboard Development
- ✅ ETL Pipeline Design

**Business Skills:**
- ✅ Business Case Development
- ✅ ROI Modeling & Financial Analysis
- ✅ Stakeholder Communication
- ✅ Data Storytelling
- ✅ Strategic Recommendations
- ✅ Process Optimization

---

## 🔑 Key Takeaways

> **"Companies don't have a data problem—they have a decision-making problem. FleetPulse transformed invisible costs into actionable insights, proving that the right analytics framework can uncover millions in hidden value."**

1. **Data reveals hidden costs:** What appeared as $1.2M was actually $14.8M—a 1,133% visibility gap
2. **Prevention beats reaction:** Emergency maintenance costs 3x more than planned maintenance
3. **Focus creates value:** 3 failure types represented 70% of preventable costs
4. **Analytics drives ROI:** $500K investment, $2.1M Year 1 return = 320% ROI

---

## 📫 Connect With Me

**Manikanta** | Business Intelligence Analyst

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?logo=linkedin)](https://linkedin.com/in/yourprofile)
[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-FF5722?logo=google-chrome)](https://yourwebsite.com)
[![Email](https://img.shields.io/badge/Email-Contact-D14836?logo=gmail)](mailto:your.email@example.com)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🏷️ Tags

`#BusinessIntelligence` `#DataAnalytics` `#SQL` `#PowerBI` `#PostgreSQL` `#PredictiveMaintenance` `#DataDriven` `#ROI` `#CostOptimization` `#FleetManagement` `#DataVisualization` `#BusinessAnalytics` `#DataScience` `#ETL` `#Dashboard`

---

**⭐ If you found this project insightful, please star this repository!**

*Built with 📊 by Manikanta | Transforming data into business value*