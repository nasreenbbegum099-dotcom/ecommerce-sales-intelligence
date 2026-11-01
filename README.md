
# E-Commerce Sales Intelligence

## Project Overview

An end-to-end data analytics project using the Olist Brazilian E-Commerce Public Dataset to analyse sales performance, customer purchasing behaviour, payment methods, seller performance, and delivery operations.

The project uses Python for data cleaning and exploration, SQL for business analysis, and Power BI for interactive dashboard development.

## Business Objectives

- Analyse overall e-commerce sales and revenue performance.
- Identify top-performing product categories and sellers.
- Understand customer repeat purchase behaviour.
- Evaluate delivery performance and customer satisfaction.
- Analyse customer payment preferences.
- Identify geographic revenue distribution across Brazilian states.

## Tools & Technologies

- **Python:** Pandas, NumPy, Matplotlib, Seaborn
- **SQL:** DuckDB
- **Business Intelligence:** Power BI
- **Data Analysis:** Data Cleaning, EDA, KPI Analysis, Business Reporting
- **Version Control:** GitHub

## Dataset

**Source:** [Olist Brazilian E-Commerce Public Dataset – Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains information about Brazilian e-commerce orders, customers, products, payments, reviews, sellers, and delivery operations.

Nine datasets were cleaned and prepared for analysis.

| Dataset | Cleaned Records |
|---|---:|
| Customers | 99,441 |
| Orders | 99,441 |
| Order Items | 112,650 |
| Payments | 103,886 |
| Reviews | 99,224 |
| Products | 32,951 |
| Sellers | 3,095 |
| Geolocation | 738,332 |
| Category Translation | 71 |

## Data Cleaning & Preparation

- Handled missing values while preserving meaningful records.
- Removed exact duplicate records where appropriate.
- Converted date columns into datetime format.
- Validated primary keys and relationships between datasets.
- Checked referential integrity across related tables.
- Prepared cleaned datasets for SQL analysis.

## SQL Business Analysis

The project includes SQL queries covering:

1. Delivered Orders and Revenue
2. Average Order Value (AOV)
3. Monthly Sales Trends
4. Top 10 Product Categories by Revenue
5. Repeat Customer Analysis
6. Delivery Performance
7. Delivery Performance vs Customer Reviews
8. Payment Method Analysis
9. Top 10 Sellers by Revenue
10. Revenue by Seller State

**SQL scripts:** [View Analysis Queries](sql/analysis_queries.sql)

## Key Business Insights

| KPI / Finding | Result |
|---|---:|
| Delivered Orders | 96,478 |
| Product Sales Revenue | R$13,221,498.11 |
| Average Order Value | R$137.04 |
| Average Delivery Time | 12.5 days |
| Late Delivery Rate | 8.11% |
| Repeat Customer Rate | 3.00% |

### Product Category Performance

- Health & Beauty generated the highest revenue of R$1,233,131.72.
- Watches & Gifts ranked second with R$1,166,176.98.
- Bed & Bath Table recorded the highest order volume among the top 10 categories, with 9,272 orders.

### Customer Retention

- Analysed 93,358 unique customers with delivered purchases.
- Identified 2,801 repeat customers.
- Repeat customer rate was 3.00%, indicating an opportunity to improve customer retention.

### Delivery & Customer Satisfaction

- Late deliveries received an average review score of 2.57 out of 5.
- On-time deliveries received an average review score of 4.29 out of 5.
- The 1.72-point difference highlights a strong association between delivery delays and lower customer satisfaction.

### Payment Analysis

- Credit cards accounted for 75.24% of payment-method order counts.
- Boleto accounted for 19.46%.
- Credit cards were the most frequently used payment method.
- Credit cards: 78.46% of total payment value.
- Boleto: 17.96% of total payment value.

### Seller & Geographic Performance

- The highest-revenue seller generated R$226,987.93.
- São Paulo generated approximately 64.4% of delivered product revenue by seller state.
- Paraná and Minas Gerais ranked second and third in seller-state revenue.

## Project Structure

```text
ecommerce-sales-intelligence/
│
├── data/
│   └── raw/
│
├── python/
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│
├── reports/
│
├── visualizations/
│
└── README.md
```

## Project Status

- [x] Dataset collection
- [x] Data cleaning and preparation
- [x] Data quality validation
- [x] SQL database setup
- [x] SQL business analysis
- [x] Initial business insights
- [x] Python exploratory data analysis
- [ ] Power BI dashboard development
- [ ] Final project report

## Author

**Nasreen Begum**

Aspiring Data Analyst | SQL | Python | Excel | Power BI | Tableau

[GitHub](https://github.com/nasreenbbegum099-dotcom)
