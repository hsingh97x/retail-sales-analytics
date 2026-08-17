# Retail Sales Analytics

## Project Overview

This project analyzes retail transaction data to identify trends in sales, profitability, product performance, customer behavior, geographic performance, and discounting.

The project demonstrates an end-to-end analytics workflow using PostgreSQL, SQL, Python, Jupyter Notebook, and Power BI. Transaction-level data was loaded into PostgreSQL for business analysis, analyzed further in Python for exploratory and statistical analysis, and visualized through an interactive Power BI dashboard.

## Business Objectives

The analysis was designed to answer several key business questions:

- How are overall revenue, profit, order volume, and profit margins performing?
- Which products and product categories generate the most revenue and profit?
- Which products contribute disproportionately to losses?
- Which customer segments and customers generate the most revenue?
- Which geographic markets perform strongest?
- How does discounting affect profitability?
- How have revenue and profit changed over time?
- How does performance vary across shipping methods?

## Tools & Technologies

- **PostgreSQL** — relational database and data storage
- **SQL** — business analysis, aggregation, segmentation, and KPI development
- **Python** — exploratory analysis, feature engineering, correlation analysis, visualization, and statistical testing
- **Pandas** — data manipulation and analysis
- **Matplotlib** — Python data visualization
- **SciPy** — statistical hypothesis testing
- **Jupyter Notebook** — Python analysis environment
- **Power BI** — interactive dashboard development and business intelligence
- **DAX** — reusable Power BI measures and KPIs

## Dataset

The project uses the Superstore retail dataset containing transaction-level information including:

- Orders and customers
- Products and product categories
- Sales and profit
- Discounts
- Geographic markets
- Shipping methods
- Order and shipping dates

The analyzed dataset covers 2014–2017.

## Analysis Workflow

### 1. PostgreSQL & SQL Analysis

The dataset was imported into PostgreSQL and analyzed using SQL across six major areas:

1. Executive KPIs
2. Product Performance
3. Customer Analytics
4. Geographic Analytics
5. Profitability & Discount Analysis
6. Sales Trends

SQL was used to calculate business metrics, identify top and bottom performers, evaluate customer and geographic performance, and investigate profitability patterns.

### 2. Python Analysis

Python was used to extend the SQL analysis through:

- Data validation
- Exploratory data analysis
- Outlier analysis
- Feature engineering
- Correlation analysis
- Statistical hypothesis testing
- Category profitability analysis
- Shipping analysis

Statistical analysis was also used to investigate relationships between discounting, product categories, and profitability.

### 3. Power BI Dashboard

A four-page interactive Power BI dashboard was developed:

#### Executive Overview
Provides high-level business KPIs and trends across revenue, profit, orders, customers, regions, and categories.

#### Product Performance
Examines category and subcategory performance, top revenue-generating products, and the products producing the largest losses.

#### Customer & Geographic Analytics
Analyzes customer segments, top customers, state-level sales performance, geographic revenue distribution, and regional performance.

#### Profitability & Sales Trends
Evaluates the relationship between discounts and profitability, monthly profit trends, and performance across shipping methods.

## Executive KPIs

| Metric | Result |
|---|---:|
| Total Revenue | $2.30M |
| Total Profit | $286.40K |
| Total Orders | 5,009 |
| Total Customers | 793 |
| Average Order Value | $458.61 |
| Profit Margin | 12.47% |

## Key Findings

- The business generated approximately **$2.30 million in revenue** and **$286 thousand in profit**, producing an overall **12.47% profit margin**.
- The **West region** generated the strongest overall revenue and profit.
- The **Central region** generated substantial revenue but comparatively weaker profitability.
- **Technology** was a particularly strong product category.
- Product-level analysis revealed that some products generated substantial revenue while others produced significant losses.
- Higher discount levels were associated with substantial deterioration in profitability.
- The **Consumer** segment represented the largest customer segment by revenue.
- **California and New York** were among the strongest states by profit.
- Revenue and profit generally strengthened over the 2014–2017 analysis period despite considerable monthly variation.
- **Standard Class** represented the largest shipping mode by revenue and profit.

## Business Recommendations

1. **Tighten discount strategy** by establishing profitability-based discount thresholds and reviewing high-discount transactions.

2. **Investigate loss-making products** to determine whether losses result from pricing, discounting, product costs, shipping costs, or other factors.

3. **Prioritize high-performing markets** and evaluate whether successful strategies in strong regions can be replicated elsewhere.

4. **Investigate Central region profitability** to identify the product, customer, or discount patterns contributing to weaker margins.

5. **Evaluate products using both revenue and profitability** rather than relying on sales volume alone.

6. **Monitor sales trends and seasonality** to support inventory planning, promotional strategy, and resource allocation.