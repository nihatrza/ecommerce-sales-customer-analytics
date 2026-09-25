# 🛒 E-Commerce Sales & Customer Analytics (SmartRetail)

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Star%20Schema-336791?logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

An end-to-end Data Analytics & Engineering project analyzing **34,500+ clean e-commerce transactions ($5.48M Net Revenue)**. The project spans automated Python ETL processing, PostgreSQL data warehousing (Star Schema), RFM customer segmentation, ad-hoc SQL business intelligence, and an interactive 3-page executive Power BI dashboard.

---

## 📌 Executive Summary

- **Financial Baseline:** Generated **$5.48M Net Revenue** and **$908.21K Net Profit** across 34,500 orders, achieving an overall **16.58% Profit Margin** and an **Average Order Value (AOV) of $158.74**.
- **Customer Valuation & Retention:** Identified **7,903 unique customers** with an **Average Revenue Per User (ARPU) of $692.97**. RFM modeling categorized **1,964 Champions** and flagged **1,659 At-Risk customers** requiring immediate re-engagement.
- **Discount Margin Leakage:** Uncovered severe margin dilution caused by promotional pricing. Profit margins dropped from **16.84%** on non-discounted orders down to **14.60%** on 30% discount tiers, sacrificing **$288K+** in potential margin.
- **Logistics & Returns:** Identified **Fashion (7.59%)** and **Electronics (6.86%)** as top return-rate drivers. Delivery delays exceeding 8 days directly correlated with elevated product return rates across all categories.

---

## 📊 Power BI Interactive Dashboard

### Dashboard Pages Architecture

**Page 1 — Sales Overview (Financial Performance & Trends)**
Focuses on macro-level business performance, sales trends across categories, payment method breakdowns, and day-of-week revenue distributions.
- Key Visuals: KPI Cards (Orders, Net Revenue, Net Profit, Margin %, AOV), Net Revenue by Category Bar Chart, Payment Method Donut Chart, Monthly Profit Trend Line, Net Revenue by Days Bar Chart.

**Page 2 — Customer Insights (Demographics & RFM Behavior)**
Analyzes customer concentration, RFM segmentation cohorts, age/gender purchasing power, and regional customer value distribution.
- Key Visuals: Top Customer KPIs (Total Customers, ARPU, Avg Orders, Champions Count, At Risk Count), Customer Segment Bar Chart, Revenue by Age Group & Gender Stacked Column Chart, Top Customers Performance Table.

**Page 3 — Product & Shipping (Discount Leakage & Logistics)**
Examines product margin profitability, discount erosion dynamics, delivery speed performance, and return rate drivers.
- Key Visuals: Operational KPIs (Total Discount, Return Rate %, Unprofitable Orders, Avg Delivery Days, Shipping Cost), Net Profit by Quantity Line Chart, Return Rate by Category & Delivery Speed Bar Chart, Product Profitability Matrix.

### Dashboard UX Features

- **Custom Palette:** Earth & Warm Beige theme (`#D4A359` / `#F9E8C9`) designed for low eye strain and high executive readability.
- **Top Slicer Bar:** Top-horizontal dropdown bar for seamless filtering across Month, Region, and Category.
- **Bookmark Actions:** Interactive 1-click Reset Filters button to clear all active slicers instantly.
- **Developer Links:** Embedded interactive web actions routing directly to LinkedIn and GitHub profiles.

---

## 💡 Key Business Insights & Strategic Recommendations

### 1. High-Value Customer Retention & Demographic Targeting
**Insight:** Top customers (e.g., C16655 with $13,885.10 Net Revenue) and core revenue drivers heavily concentrate within the 26–35 and 36–50 age cohorts ($1.9M+ revenue each).
**Recommendation:** Establish an automated loyalty campaign for Champions (1,964 customers) while deploying targeted re-activation email flows with personalized offers for At-Risk customers (1,659 count) before complete churn occurs.

### 2. Discount Policy Restructuring
**Insight:** While discounts increase gross order volume, high-tier discounts severely erode profitability. Orders with 30% discounts yield only a 14.60% margin compared to 16.84% at full price.
**Recommendation:** Cap promotional discounts at 10–15%. Shift marketing incentives from direct price cuts to value-add bundling (e.g., "Free Shipping over $150" or "Buy 2 Get 1 at 20% off") to protect net margin.

### 3. Category Management & Quality Control
**Insight:** Sports (22.46%) and Beauty (22.36%) boast the highest profit margins, whereas Electronics generates high volume ($2.45M) but operates on a thin 11.03% margin. Fashion suffers from the highest return rate (7.59%).
**Recommendation:** Expand catalog offerings in high-margin categories (Sports & Beauty). For Fashion, update sizing guides and vendor quality audits to reduce product return rates.

### 4. Purchasing Behavior: Business Days vs. Weekends
**Insight:** Weekdays generate 71.7% of total revenue ($3.91M), but weekend orders yield a higher Average Order Value ($169.58 vs $167.39).
**Recommendation:** Launch weekend-specific cross-selling prompts at checkout to capitalize on larger basket sizes during non-working days.

---

## 🏗️ Architecture & Data Pipeline Workflow

```
[ Raw Data CSV ] ──► [ Python ETL Script ] ──► [ PostgreSQL Warehouse ] ──► [ Power BI Dashboard ]
    (34.5K Records)     (Data Cleaning & FE)     (Star Schema Database)      (3-Page Executive UI)
```

- **Extraction & Transformation (Python):** Cleaned raw data, handled missing values, formatted dates, engineered demographic age bins (18-25, 26-35, etc.), categorized delivery speeds, and derived net financial metrics considering returns.
- **Data Warehousing (PostgreSQL):** Designed a dimensional Star Schema with `fact_sales` and supporting dimension tables (`dim_customer`, `dim_product`, `dim_date`).
- **Data Intelligence (SQL Queries):** Authored ad-hoc PostgreSQL queries analyzing customer lifetime values, discount margin leakage, category performance, and weekend purchasing patterns.
- **Data Visualization (Power BI):** Developed an executive 3-page interactive report with custom DAX measures, dynamic slicers, bookmark resets, and UX-optimized navigation.

---

## 🗄️ Database Schema (Star Schema)

```
                  ┌─────────────────┐
                  │  dim_customer   │
                  ├─────────────────┤
                  │ PK  customer_id │
                  └────────┬────────┘
                           │ 1
                           │
                           │ N
┌─────────────────┐       ┌┴───────────────────────────┐       ┌─────────────────┐
│   dim_product   │       │        fact_sales          │       │    dim_date     │
├─────────────────┤       ├────────────────────────────┤       ├─────────────────┤
│ PK  product_id  │1─────N│ PK  order_id               │N─────1│ PK  date        │
└─────────────────┘       │ FK  customer_id            │       └─────────────────┘
                           │ FK  product_id             │
                           │ FK  order_date             │
                           │     payment_method         │
                           │     quantity, discount     │
                           │     gross_amount           │
                           │     discount_amount        │
                           │     total_amount           │
                           │     shipping_cost          │
                           │     profit_margin          │
                           │     net_revenue, net_profit│
                           │     returned               │
                           │     delivery_time_days     │
                           │     delivery_speed         │
                           └────────────────────────────┘
```

---

## 🔍 Key Business Questions & SQL Analytics

### Query 1: Top 10 High-Value Customers by Net Revenue

```sql
SELECT 
    c.customer_id,
    c.region,
    c.age_group,
    COUNT(f.order_id) AS total_orders,
    ROUND(SUM(f.net_revenue), 2) AS total_net_revenue,
    ROUND(SUM(f.net_profit), 2) AS total_net_profit
FROM fact_sales f
JOIN dim_customer c ON f.customer_id = c.customer_id
WHERE f.returned = 0
GROUP BY c.customer_id, c.region, c.age_group
ORDER BY total_net_revenue DESC
LIMIT 10;
```

**Query Output:**

| customer_id | region | age_group | total_orders | total_net_revenue ($) | total_net_profit ($) |
|---|---|---|---|---|---|
| C16655 | Central | 36-50 | 10 | $13,885.10 | $1,689.30 |
| C13565 | South | 26-35 | 5 | $11,984.28 | $1,452.04 |
| C15379 | West | 36-50 | 3 | $11,375.58 | $1,361.82 |
| C17116 | West | 26-35 | 5 | $7,424.34 | $1,029.79 |
| C15644 | North | 51-65 | 7 | $7,244.07 | $832.43 |

> 📌 **Key Takeaway:** The top customer (C16655) generated $13,885.10 in Net Revenue across 10 orders. High-value customers heavily concentrate within the 26–35 and 36–50 age brackets.

### Query 2: Discount vs. Profitability Leakage Analysis

```sql
SELECT 
    f.discount,
    COUNT(f.order_id) AS total_orders,
    ROUND(SUM(f.gross_amount), 2) AS total_gross_revenue,
    ROUND(SUM(f.discount_amount), 2) AS total_discount_given,
    ROUND(SUM(f.net_profit), 2) AS total_net_profit,
    ROUND((SUM(f.net_profit) / NULLIF(SUM(f.net_revenue), 0)) * 100, 2) AS profit_margin_pct
FROM fact_sales f
WHERE f.returned = 0
GROUP BY f.discount
ORDER BY f.discount ASC;
```

**Query Output:**

| discount | total_orders | total_gross_revenue ($) | total_discount_given ($) | total_net_profit ($) | profit_margin_pct (%) |
|---|---|---|---|---|---|
| 0.00 | 17,914 | $3,171,577.48 | $0.00 | $533,949.34 | 16.84% |
| 0.05 | 5,804 | $1,003,044.75 | $50,152.27 | $158,500.92 | 16.63% |
| 0.10 | 3,932 | $690,815.48 | $69,081.26 | $100,774.70 | 16.21% |
| 0.15 | 2,635 | $477,227.20 | $71,584.31 | $64,972.60 | 16.02% |
| 0.20 | 1,638 | $291,719.34 | $58,343.74 | $36,687.76 | 15.72% |
| 0.30 | 674 | $130,449.35 | $39,134.94 | $13,328.63 | 14.60% |

> 📌 **Key Takeaway:** Profit margin degrades predictably from 16.84% at 0% discount down to 14.60% at 30% discount, proving that steep promotional discounts erode net margin without proportional volume gains.

### Query 3: Category Profitability & Return Performance

```sql
SELECT 
    p.category,
    COUNT(f.order_id) AS total_orders,
    ROUND(SUM(f.net_revenue), 2) AS net_revenue,
    ROUND(SUM(f.net_profit), 2) AS net_profit,
    ROUND((SUM(f.net_profit) / NULLIF(SUM(f.net_revenue), 0)) * 100, 2) AS profit_margin_pct,
    ROUND((SUM(f.returned)::NUMERIC / COUNT(f.order_id)) * 100, 2) AS return_rate_pct
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY net_profit DESC;
```

**Query Output:**

| category | total_orders | net_revenue ($) | net_profit ($) | profit_margin_pct (%) | return_rate_pct (%) |
|---|---|---|---|---|---|
| Electronics | 6,199 | $2,449,100.23 | $270,187.32 | 11.03% | 6.86% |
| Home | 5,454 | $994,012.68 | $221,838.29 | 22.32% | 5.35% |
| Sports | 4,137 | $630,429.85 | $141,619.85 | 22.46% | 4.83% |
| Fashion | 6,261 | $590,655.94 | $131,377.29 | 22.24% | 7.59% |
| Beauty | 4,111 | $296,148.50 | $66,223.92 | 22.36% | 4.28% |
| Toys | 4,163 | $279,944.51 | $53,014.87 | 18.94% | 5.38% |
| Grocery | 4,175 | $236,245.37 | $23,952.41 | 10.14% | 2.66% |

> 📌 **Key Takeaway:** Electronics drives the highest absolute profit ($270.18K), but Sports, Beauty, and Home yield double the profit margin (~22.4%). Fashion represents the highest operational risk with a 7.59% return rate.

### Query 4: Business Day vs. Weekend Purchasing Patterns

```sql
SELECT 
    CASE WHEN d.is_weekend = 1 THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    COUNT(f.order_id) AS total_orders,
    ROUND(SUM(f.net_revenue), 2) AS total_net_revenue,
    ROUND(AVG(f.net_revenue), 2) AS avg_order_value,
    ROUND(SUM(f.net_profit), 2) AS total_net_profit
FROM fact_sales f
JOIN dim_date d ON f.order_date = d.date
WHERE f.returned = 0
GROUP BY d.is_weekend
ORDER BY total_net_revenue DESC;
```

**Query Output:**

| day_type | total_orders | total_net_revenue ($) | avg_order_value ($) | total_net_profit ($) |
|---|---|---|---|---|
| Weekday | 23,361 | $3,910,308.96 | $167.39 | $649,449.03 |
| Weekend | 9,236 | $1,566,228.12 | $169.58 | $258,764.92 |

> 📌 **Key Takeaway:** Weekdays drive the bulk of revenue volume ($3.91M), but weekend shoppers spend slightly more per transaction ($169.58 AOV vs $167.39).

---

## 📁 Repository Structure

```
ecommerce-sales-customer-analytics/
│
├── assets/
│   ├── sales_overview.png
│   ├── customer_insights.png
│   └── product_shipping.png
│
├── sql/
│   ├── 01_schema_setup.sql
│   └── 02_adhoc_analytics.sql
│
├── python/
│   └── etl_pipeline.py
│
├── powerbi/
│   └── E-Commerce_Sales_Analytics.pbix
│
├── data/
│   ├── fact_sales.csv
│   ├── dim_customer.csv
│   ├── dim_product.csv
│   └── dim_date.csv
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## 💻 How to Run / Reproduce

**1. Clone the Repository**
```bash
git clone https://github.com/nihatrzaguluzada/ecommerce-sales-customer-analytics.git
cd ecommerce-sales-customer-analytics
```

**2. Execute Python ETL Pipeline**
```bash
python python/etl_pipeline.py
```

**3. Database Setup (PostgreSQL)**
- Execute `sql/01_schema_setup.sql` to build Star Schema tables and foreign keys.
- Import the processed CSV files from `data/` into their respective PostgreSQL tables.
- Execute `sql/02_adhoc_analytics.sql` to run business analysis queries.

**4. Open Power BI Dashboard**
- Open `powerbi/E-Commerce_Sales_Analytics.pbix` in Power BI Desktop.
- Verify or refresh data source connections if prompted.

---

## 👤 Author

**Nihat Rzaguluzade** | Certified Data Analyst

This project was developed as an end-to-end professional Data Analytics & Engineering portfolio project, demonstrating technical expertise in Python, PostgreSQL ETL processes, SQL analytics, DAX engineering, and Power BI dashboard design.
