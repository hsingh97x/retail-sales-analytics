SELECT
    discount,
    COUNT(*) AS order_lines,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales),2) AS profit_margin_pct
FROM superstore_orders
GROUP BY discount
ORDER BY discount;

SELECT
    category,
    ROUND(AVG(discount) * 100,2) AS avg_discount_pct,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM superstore_orders
GROUP BY category
ORDER BY avg_discount_pct DESC;

SELECT
    discount,
    ROUND(AVG(profit),2) AS avg_profit_per_order,
    ROUND(AVG(sales),2) AS avg_sales_per_order
FROM superstore_orders
GROUP BY discount
ORDER BY discount;

SELECT
    order_id,
    customer_name,
    product_name,
    sales,
    profit,
    discount
FROM superstore_orders
WHERE profit < 0
ORDER BY profit ASC
LIMIT 20;

SELECT
    order_id,
    customer_name,
    product_name,
    sales,
    profit
FROM superstore_orders
ORDER BY profit DESC
LIMIT 20;

SELECT
    ship_mode,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales),2) AS profit_margin_pct
FROM superstore_orders
GROUP BY ship_mode
ORDER BY revenue DESC;

SELECT
    ROUND(CORR(discount, profit)::numeric,4) AS correlation
FROM superstore_orders;

SELECT
    region,
    ROUND(AVG(profit),2) AS avg_profit_per_order,
    ROUND(AVG(discount) * 100,2) AS avg_discount_pct
FROM superstore_orders
GROUP BY region
ORDER BY avg_profit_per_order DESC;