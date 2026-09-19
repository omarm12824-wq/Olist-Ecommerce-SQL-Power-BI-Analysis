# Olist E-Commerce Analysis | SQL & Power BI

## Project Overview

This project presents an end-to-end analysis of the **Olist Brazilian E-Commerce dataset** using **MySQL and Power BI**.

The analysis focuses on understanding sales performance, customer activity, product categories, seller performance, delivery efficiency, and the relationship between delivery delays and customer satisfaction.

The project combines **SQL-based business analysis** with an interactive **Power BI dashboard** designed to communicate the main findings clearly.

---

## Tools Used

- **MySQL** – Data exploration, joins, aggregations, and business analysis
- **Power BI** – Data modeling, DAX measures, visualization, and dashboard design
- **Power Query** – Data preparation and transformation

---

## Business Questions

The analysis was designed to answer questions such as:

- How much revenue was generated and how did it change over time?
- Which product categories generate the most revenue?
- Which states contribute the most to total revenue?
- Which sellers generate the highest revenue?
- What percentage of delivered orders arrive late?
- Which states have the highest late-delivery rates?
- How does delivery delay affect customer review scores?
- What is the overall distribution of customer ratings?

---

## Dashboard

### 1. Executive Overview

The Executive Overview provides a high-level view of overall business performance, including revenue, orders, customers, average order value, delivery performance, and customer reviews.

![Executive Overview](Executive%20overview.png)

### 2. Performance Deep Dive

The second page focuses on operational performance, including late deliveries by state, seller performance, delay severity, and customer review distribution.

![Performance Deep Dive](Performance%20Deep%20Dive.png)

---

## Key Insights

- Total revenue reached approximately **13.59M** from **99.44K orders**.
- The average order value was approximately **136.68**.
- **São Paulo (SP)** was the largest market, generating approximately **5.2M** in revenue.
- **Health & Beauty** was the highest revenue-generating product category at approximately **1.26M**.
- Approximately **8.11%** of delivered orders were delivered late.
- Average delivery time was approximately **12.5 days**.
- On-time deliveries received an average review score of approximately **4.3**, compared with approximately **2.6** for late deliveries.
- Customer satisfaction declined further as delivery delays increased, with average review scores falling to around **1.7** for longer delays.
- **5-star reviews** dominated customer feedback, while **1-star reviews** still represented a notable share of reviews.

---

## SQL Analysis

The SQL analysis includes:

- Revenue and order analysis
- Customer analysis
- Monthly and yearly performance
- Product category analysis
- Seller performance
- Delivery performance
- Late-delivery analysis by state
- Review score analysis
- Delivery delay severity analysis

The SQL queries used in the project are available here:

[`Olist_SQL_Analysis.sql`](Olist_SQL_Analysis.sql)

---

## Power BI Data Model

The Power BI model connects the main business tables including:

- Orders
- Order Items
- Customers
- Products
- Sellers
- Order Reviews
- Calendar

A dedicated measures table was used to organize the main DAX calculations.

---

## Key Power BI Measures

The dashboard includes measures such as:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Delivered Orders
- Late Orders
- Late Delivery %
- Average Delivery Days
- Average Review Score
- Previous Year Revenue
- Revenue YoY Growth %

---

## Skills Demonstrated

**SQL**
- JOINs
- GROUP BY
- Aggregations
- CASE WHEN
- Date functions
- Conditional analysis
- Business-oriented querying

**Power BI**
- Data modeling
- Relationships
- DAX measures
- Date table and time intelligence
- KPI design
- Interactive filtering
- Dashboard design
- Business storytelling

---

## Project Structure

- `Olist_SQL_Analysis.sql` – SQL analysis queries
- `Executive overview.png` – Executive dashboard screenshot
- `Performance Deep Dive.png` – Performance analysis dashboard screenshot
- `README.md` – Project documentation

---

## Author

**Omar Ahmed**

Aspiring Data Analyst | Power BI | SQL | Excel | Business Analysis
