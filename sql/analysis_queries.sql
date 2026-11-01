
-- ============================================================
-- PROJECT: E-Commerce Sales Intelligence
-- DATASET: Olist Brazilian E-Commerce Public Dataset
-- DATABASE: DuckDB
-- PURPOSE: Business analysis using SQL
-- ============================================================


-- 1. DELIVERED ORDERS AND REVENUE
-- Calculate delivered orders, items sold, product sales and freight.

SELECT
    COUNT(DISTINCT o.order_id) AS total_delivered_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS product_sales_brl,
    ROUND(SUM(oi.freight_value), 2) AS freight_brl
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- 2. AVERAGE ORDER VALUE (AOV)
-- Calculate average product spending per delivered order.
-- Freight is excluded.

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_sales,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';


-- 3. MONTHLY SALES TREND
-- Analyse monthly product sales and order volume.

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS sales_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS monthly_sales_brl
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;


-- 4. TOP 10 PRODUCT CATEGORIES BY REVENUE
-- Identify the highest-revenue product categories.

SELECT
    p.product_category_name_english AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue_brl
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY total_revenue_brl DESC
LIMIT 10;


-- 5. REPEAT CUSTOMER ANALYSIS
-- Identify customers who made more than one delivered purchase.
-- customer_unique_id identifies the same customer across records.

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS delivered_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN delivered_orders > 1 THEN 1
            ELSE 0
        END
    ) AS repeat_customers,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN delivered_orders > 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;


-- 6. DELIVERY PERFORMANCE
-- Calculate average delivery time and late delivery rate.
-- Exclude orders with missing delivery or estimated dates.

SELECT
    COUNT(*) AS total_delivered_orders,
    ROUND(
        AVG(
            DATE_DIFF(
                'day',
                order_purchase_timestamp,
                order_delivered_customer_date
            )
        ),
        2
    ) AS avg_delivery_days,
    ROUND(
        AVG(
            CASE
                WHEN order_delivered_customer_date
                     > order_estimated_delivery_date
                THEN 1.0
                ELSE 0.0
            END
        ) * 100,
        2
    ) AS late_delivery_rate_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- 7. DELIVERY PERFORMANCE VS CUSTOMER REVIEWS
-- Compare average review scores for late and on-time orders.
-- Average multiple reviews per order before joining.

WITH delivery_status AS (
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date
                 > order_estimated_delivery_date
            THEN 'Late'
            ELSE 'On Time'
        END AS delivery_status
    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
),

order_reviews AS (
    SELECT
        order_id,
        AVG(review_score) AS average_review_score
    FROM reviews
    GROUP BY order_id
)

SELECT
    d.delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(r.average_review_score), 2) AS avg_review_score
FROM delivery_status d
JOIN order_reviews r
    ON d.order_id = r.order_id
GROUP BY d.delivery_status
ORDER BY d.delivery_status;


-- 8. PAYMENT METHOD ANALYSIS
-- Compare payment records, order counts and payment values.
-- Order share is based on payment-method order counts.

SELECT
    payment_type,
    COUNT(*) AS total_payment_records,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_payment_value_brl,
    ROUND(
        100.0 * COUNT(DISTINCT order_id)
        / SUM(COUNT(DISTINCT order_id)) OVER (),
        2
    ) AS payment_order_share_pct
FROM payments
GROUP BY payment_type
ORDER BY total_orders DESC;


-- 9. TOP 10 SELLERS BY REVENUE
-- Identify top sellers based on delivered product revenue.

SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue_brl
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY
    s.seller_id,
    s.seller_state
ORDER BY total_revenue_brl DESC
LIMIT 10;


-- 10. REVENUE BY SELLER STATE
-- Compare seller revenue and order volume across Brazilian states.

SELECT
    s.seller_state,
    COUNT(DISTINCT s.seller_id) AS total_sellers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue_brl
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_state
ORDER BY total_revenue_brl DESC;
