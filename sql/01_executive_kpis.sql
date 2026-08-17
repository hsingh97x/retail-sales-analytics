SELECT
    ROUND(SUM(sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct
FROM superstore_orders;

SELECT
    region,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct
FROM superstore_orders
GROUP BY region
ORDER BY revenue DESC;

SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders
FROM superstore_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

SELECT
    EXTRACT(YEAR FROM order_date)::integer AS year,
    ROUND(SUM(sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS orders,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_pct
FROM superstore_orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

