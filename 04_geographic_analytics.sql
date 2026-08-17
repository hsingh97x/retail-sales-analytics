SELECT
    state,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit,
    ROUND(100 * SUM(profit) / SUM(sales),2) AS profit_margin_pct
FROM superstore_orders
GROUP BY state
ORDER BY revenue DESC;

SELECT
    city,
    state,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM superstore_orders
GROUP BY
    city,
    state
ORDER BY revenue DESC
LIMIT 10;

SELECT
    city,
    state,
    ROUND(SUM(sales),2) AS revenue,
    ROUND(SUM(profit),2) AS profit
FROM superstore_orders
GROUP BY
    city,
    state
HAVING SUM(profit) < 0
ORDER BY profit
LIMIT 10;

SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    region,
    ROUND(SUM(sales),2) AS revenue
FROM superstore_orders
GROUP BY
    DATE_TRUNC('month', order_date),
    region
ORDER BY
    month,
    region;

SELECT
    state,
    ROUND(
        SUM(sales) /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM superstore_orders
GROUP BY state
ORDER BY average_order_value DESC;

SELECT
    state,
    COUNT(DISTINCT customer_id) AS customers
FROM superstore_orders
GROUP BY state
ORDER BY customers DESC;

WITH state_customers AS (

SELECT
    state,
    COUNT(DISTINCT customer_id) AS customers,
    SUM(sales) AS revenue

FROM superstore_orders

GROUP BY state

)

SELECT

state,

customers,

ROUND(revenue,2) revenue,

ROUND(revenue/customers,2) revenue_per_customer

FROM state_customers

ORDER BY revenue_per_customer DESC;

WITH state_revenue AS (

SELECT

state,

SUM(sales) revenue

FROM superstore_orders

GROUP BY state

),

ranked_states AS (

SELECT

state,

revenue,

SUM(revenue) OVER(
ORDER BY revenue DESC
) cumulative_revenue,

SUM(revenue) OVER() total_revenue

FROM state_revenue

)

SELECT

state,

ROUND(revenue,2),

ROUND(
100*cumulative_revenue/total_revenue,
2
) cumulative_pct

FROM ranked_states

ORDER BY revenue DESC;