SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders
FROM superstore_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM order_date)::integer AS year,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY EXTRACT(YEAR FROM order_date)
)

SELECT
    year,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        100 * (
            revenue - LAG(revenue) OVER (ORDER BY year)
        ) /
        LAG(revenue) OVER (ORDER BY year),
        2
    ) AS yoy_growth_pct
FROM yearly_sales
ORDER BY year;

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        100 * (
            revenue - LAG(revenue, 12) OVER (ORDER BY month)
        ) /
        LAG(revenue, 12) OVER (ORDER BY month),
        2
    ) AS yoy_growth_pct
FROM monthly_sales
ORDER BY month;

SELECT
    EXTRACT(YEAR FROM order_date)::integer AS year,
    EXTRACT(QUARTER FROM order_date)::integer AS quarter,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders
FROM superstore_orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY year, quarter;

SELECT
    EXTRACT(MONTH FROM order_date)::integer AS month_number,
    TO_CHAR(order_date, 'Month') AS month_name,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM superstore_orders
GROUP BY
    EXTRACT(MONTH FROM order_date),
    TO_CHAR(order_date, 'Month')
ORDER BY month_number;

SELECT
    EXTRACT(DOW FROM order_date)::integer AS day_number,
    TO_CHAR(order_date, 'Day') AS day_name,
    ROUND(SUM(sales), 2) AS revenue,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(
        SUM(sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM superstore_orders
GROUP BY
    EXTRACT(DOW FROM order_date),
    TO_CHAR(order_date, 'Day')
ORDER BY day_number;

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS revenue
    FROM superstore_orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_3_month_avg
FROM monthly_sales
ORDER BY month;

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(sales) AS revenue,
        SUM(profit) AS profit
    FROM superstore_orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(profit, 2) AS profit
FROM monthly_sales
ORDER BY revenue DESC;