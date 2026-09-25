-- ==========================================
-- E-Commerce Business Intelligence & Ad-hoc SQL Queries
-- Author: Nihat Rzaguluzada
-- Description: Business queries analyzing revenue, customer behavior,
--              discount impact, and delivery performance in PostgreSQL.
-- ==========================================

-- ----------------------------------------------------
-- Query 1: Top 10 High-Value Customers by Net Revenue
-- Objective: Identify top contributors to total business revenue.
-- ----------------------------------------------------
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

-- ----------------------------------------------------
-- Query 2: Discount vs. Profitability Leakage Analysis
-- Objective: Evaluate how higher discount tiers impact net profit margin.
-- ----------------------------------------------------
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

-- ----------------------------------------------------
-- Query 3: Logistics Impact - Delivery Speed vs. Return Rate
-- Objective: Measure how shipping delays directly affect order return rates.
-- ----------------------------------------------------
SELECT 
    f.delivery_speed,
    COUNT(f.order_id) AS total_orders,
    SUM(f.returned) AS total_returned_orders,
    ROUND((SUM(f.returned)::NUMERIC / COUNT(f.order_id)) * 100, 2) AS return_rate_pct,
    ROUND(AVG(f.shipping_cost), 2) AS avg_shipping_cost
FROM fact_sales f
GROUP BY f.delivery_speed
ORDER BY return_rate_pct DESC;

-- ----------------------------------------------------
-- Query 4: Category Profitability & Return Performance
-- Objective: Rank categories by net profit, revenue, and return rate.
-- ----------------------------------------------------
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

-- ----------------------------------------------------
-- Query 5: Business Day vs. Weekend Purchasing Patterns
-- Objective: Compare weekday vs. weekend sales performance.
-- ----------------------------------------------------
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