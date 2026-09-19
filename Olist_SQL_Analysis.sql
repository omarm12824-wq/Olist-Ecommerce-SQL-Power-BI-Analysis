-- ============================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- SQL Portfolio Project
-- ============================================================
-- Objective:
-- Analyze sales performance, customer growth, product categories,
-- seller performance, delivery efficiency, and customer reviews.
-- ============================================================


-- ============================================================
-- 1. OVERALL BUSINESS PERFORMANCE
-- ============================================================

-- Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- Total Unique Customers
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;


-- Total Revenue
SELECT
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items;


-- Average Order Value
SELECT
    ROUND(
        SUM(price) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM order_items;



-- ============================================================
-- 2. MONTHLY REVENUE TREND
-- ============================================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS year_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY
    year_month;



-- ============================================================
-- 3. YEARLY BUSINESS PERFORMANCE
-- ============================================================

SELECT
    YEAR(o.order_purchase_timestamp) AS year,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    ROUND(SUM(oi.price), 2) AS revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    YEAR(o.order_purchase_timestamp)
ORDER BY
    year;



-- ============================================================
-- 4. TOP PRODUCT CATEGORIES BY SALES VOLUME
-- ============================================================

SELECT
    p.product_category_name,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY
    p.product_category_name
ORDER BY
    items_sold DESC
LIMIT 10;



-- ============================================================
-- 5. TOP PRODUCT CATEGORIES BY REVENUE
-- ============================================================

SELECT
    p.product_category_name,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY
    p.product_category_name
ORDER BY
    revenue DESC
LIMIT 10;



-- ============================================================
-- 6. TOP SELLERS BY REVENUE
-- ============================================================

SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
GROUP BY
    oi.seller_id
ORDER BY
    revenue DESC
LIMIT 10;



-- ============================================================
-- 7. DELIVERY PERFORMANCE
-- ============================================================

-- Average Delivery Time

SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- ============================================================
-- 8. LATE DELIVERY RATE
-- ============================================================

SELECT
    COUNT(*) AS delivered_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN order_delivered_customer_date >
                     order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage

FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- ============================================================
-- 9. LATE DELIVERY RATE BY CUSTOMER STATE
-- ============================================================

SELECT
    c.customer_state,

    COUNT(*) AS delivered_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage

FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY
    c.customer_state

ORDER BY
    late_delivery_percentage DESC;



-- ============================================================
-- 10. AVERAGE REVIEW SCORE
-- ============================================================

SELECT
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews;



-- ============================================================
-- 11. REVIEW SCORE DISTRIBUTION
-- ============================================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY
    review_score
ORDER BY
    review_score;



-- ============================================================
-- 12. CUSTOMER SATISFACTION: ON-TIME VS LATE DELIVERY
-- ============================================================

SELECT
    CASE
        WHEN o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        AVG(r.review_score),
        2
    ) AS avg_review_score

FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY
    delivery_status;



-- ============================================================
-- 13. REVIEW SCORE BY DELAY SEVERITY
-- ============================================================

SELECT
    CASE
        WHEN o.order_delivered_customer_date <=
             o.order_estimated_delivery_date
            THEN 'On Time'

        WHEN DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
             ) BETWEEN 1 AND 3
            THEN '1-3 Days Late'

        WHEN DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
             ) BETWEEN 4 AND 7
            THEN '4-7 Days Late'

        WHEN DATEDIFF(
                o.order_delivered_customer_date,
                o.order_estimated_delivery_date
             ) BETWEEN 8 AND 14
            THEN '8-14 Days Late'

        ELSE '15+ Days Late'
    END AS delay_severity,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(
        AVG(r.review_score),
        2
    ) AS avg_review_score

FROM orders o
JOIN order_reviews r
    ON o.order_id = r.order_id

WHERE o.order_delivered_customer_date IS NOT NULL

GROUP BY
    delay_severity

ORDER BY
    CASE delay_severity
        WHEN 'On Time' THEN 1
        WHEN '1-3 Days Late' THEN 2
        WHEN '4-7 Days Late' THEN 3
        WHEN '8-14 Days Late' THEN 4
        WHEN '15+ Days Late' THEN 5
    END;
