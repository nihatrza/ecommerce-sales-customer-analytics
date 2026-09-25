-- ==========================================
-- E-Commerce Analytics Database Setup (DDL)
-- Author: Nihat Rzaguluzada
-- Description: Creates Star Schema database tables (Dimensions & Fact)
--              for PostgreSQL ingestion and analysis.
-- ==========================================


-- 1. Customer Dimension Table
CREATE TABLE dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_age INT,
    customer_gender VARCHAR(20),
    age_group VARCHAR(20),
    region VARCHAR(50)
);

-- 2. Product Dimension Table
CREATE TABLE dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    category VARCHAR(50),
    price NUMERIC(10, 2)
);

-- 3. Date Dimension Table
CREATE TABLE dim_date (
    date DATE PRIMARY KEY,
    year INT,
    quarter VARCHAR(10),
    month INT,
    month_name VARCHAR(20),
    day INT,
    day_of_week VARCHAR(20),
    day_number_of_week INT,
    is_weekend INT
);

-- 4. Sales Fact Table
CREATE TABLE fact_sales (
    order_id VARCHAR(50),
    customer_id VARCHAR(50) REFERENCES dim_customer(customer_id),
    product_id VARCHAR(50) REFERENCES dim_product(product_id),
    order_date DATE REFERENCES dim_date(date),
    payment_method VARCHAR(50),
    quantity INT,
    discount NUMERIC(5, 2),
    gross_amount NUMERIC(12, 2),
    discount_amount NUMERIC(12, 2),
    total_amount NUMERIC(12, 2),
    shipping_cost NUMERIC(10, 2),
    profit_margin NUMERIC(12, 2),
    net_revenue NUMERIC(12, 2),
    net_profit NUMERIC(12, 2),
    returned INT,
    is_unprofitable INT,
    delivery_time_days INT,
    delivery_speed VARCHAR(50)
);