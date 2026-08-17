SELECT
    category,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales), 2) AS profit_margin_pct,
    COUNT(*) AS order_lines
FROM superstore_orders
GROUP BY category
ORDER BY revenue DESC;

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(100 * SUM(profit)/SUM(sales),2) AS profit_margin_pct
FROM superstore_orders
GROUP BY sub_category
ORDER BY revenue DESC;

SELECT
    product_name,
    ROUND(SUM(sales),2) AS revenue
FROM superstore_orders
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

SELECT
    product_name,
    ROUND(SUM(profit),2) AS profit
FROM superstore_orders
GROUP BY product_name
ORDER BY profit DESC
LIMIT 10;

SELECT
    product_name,
    ROUND(SUM(profit),2) AS profit
FROM superstore_orders
GROUP BY product_name
ORDER BY profit ASC
LIMIT 10;

SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    category,
    ROUND(SUM(sales),2) AS revenue
FROM superstore_orders
GROUP BY
    DATE_TRUNC('month', order_date),
    category
ORDER BY month, category;

SELECT
    category,
    ROUND(AVG(discount) * 100,2) AS avg_discount_pct
FROM superstore_orders
GROUP BY category
ORDER BY avg_discount_pct DESC;

WITH product_revenue AS (
    SELECT
        product_name,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY product_name
),

ranked_products AS (
    SELECT
        product_name,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM product_revenue
)

SELECT
    product_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        100 * cumulative_revenue / total_revenue,
        2
    ) AS cumulative_revenue_pct,
    CASE
        WHEN cumulative_revenue / total_revenue <= 0.80 THEN 'A'
        WHEN cumulative_revenue / total_revenue <= 0.95 THEN 'B'
        ELSE 'C'
    END AS abc_class
FROM ranked_products
ORDER BY revenue DESC;

WITH product_revenue AS (
    SELECT
        product_name,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY product_name
),

ranked_products AS (
    SELECT
        product_name,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue
    FROM product_revenue
),

classified_products AS (
    SELECT
        product_name,
        revenue,
        CASE
            WHEN cumulative_revenue / total_revenue <= 0.80 THEN 'A'
            WHEN cumulative_revenue / total_revenue <= 0.95 THEN 'B'
            ELSE 'C'
        END AS abc_class
    FROM ranked_products
)

SELECT
    abc_class,
    COUNT(*) AS product_count,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        100 * SUM(revenue) / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_share_pct
FROM classified_products
GROUP BY abc_class
ORDER BY abc_class;