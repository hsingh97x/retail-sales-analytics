SELECT
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales), 2) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM superstore_orders
GROUP BY segment
ORDER BY revenue DESC;

SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders
FROM superstore_orders
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY revenue DESC
LIMIT 10;

SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales), 2) AS profit_margin_pct
FROM superstore_orders
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY profit DESC
LIMIT 10;

SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND(100 * SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin_pct
FROM superstore_orders
GROUP BY
    customer_id,
    customer_name,
    segment
HAVING SUM(profit) < 0
ORDER BY profit ASC
LIMIT 10;

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS lifetime_revenue,
    ROUND(SUM(profit), 2) AS lifetime_profit
FROM superstore_orders
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY total_orders DESC, lifetime_revenue DESC
LIMIT 10;

WITH customer_totals AS (
    SELECT
        customer_id,
        segment,
        SUM(sales) AS customer_revenue,
        SUM(profit) AS customer_profit
    FROM superstore_orders
    GROUP BY
        customer_id,
        segment
)

SELECT
    segment,
    COUNT(*) AS customers,
    ROUND(AVG(customer_revenue), 2) AS avg_revenue_per_customer,
    ROUND(AVG(customer_profit), 2) AS avg_profit_per_customer
FROM customer_totals
GROUP BY segment
ORDER BY avg_revenue_per_customer DESC;

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM superstore_orders
    GROUP BY customer_id
)

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
    COUNT(*) FILTER (WHERE order_count = 1) AS one_time_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / COUNT(*),
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;

WITH customer_revenue AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY
        customer_id,
        customer_name
),

ranked_customers AS (
    SELECT
        customer_id,
        customer_name,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue,
        SUM(revenue) OVER () AS total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY revenue DESC
        ) AS customer_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_revenue
)

SELECT
    CASE
        WHEN customer_rank <= CEIL(total_customers * 0.10) THEN 'Top 10%'
        WHEN customer_rank <= CEIL(total_customers * 0.20) THEN 'Next 10%'
        ELSE 'Remaining 80%'
    END AS customer_group,
    COUNT(*) AS customer_count,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(
        100 * SUM(revenue) / MAX(total_revenue),
        2
    ) AS revenue_share_pct
FROM ranked_customers
GROUP BY
    CASE
        WHEN customer_rank <= CEIL(total_customers * 0.10) THEN 'Top 10%'
        WHEN customer_rank <= CEIL(total_customers * 0.20) THEN 'Next 10%'
        ELSE 'Remaining 80%'
    END
ORDER BY revenue DESC;