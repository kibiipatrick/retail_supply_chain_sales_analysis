# Retail Supply Chain Sales Analysis | USA

## Overview
This project analyzes **9,994 rows and 23 columns** of Retail Supply Chain Sales Data using **Tableau, SQL & Python**.  

The analysis explores:

- Market and geographic distribution of sales.
- Product performance across categories and sub-categories
- Sales trends over time
- Shipping duration and fulfilment performance

The goal is to identify patterns and opportunities for data-driven decision-making and market expansion.


Dataset: [Retail Supply Chain Sales (Kaggle)](https://www.kaggle.com/datasets/shandeep777/retail-supply-chain-sales-dataset)  

---

# Project Links


### Tableau Dashboards
- **Performance & Fullfilment Overview** *([Tableau Public link](https://public.tableau.com/views/RetailSupplyChainSalesUSA/SupplyChainOverview?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link))* 
- **Supply Chain Sales Dashboard** *([Tableau Public link](https://public.tableau.com/views/RetailSupplyChainSalesUSA/SupplyChainSalesDashboard?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link))*  
 

 ### SQL Scripts
- **Data Cleaning and EDA:** *([Link](https://github.com/kibiipatrick/retail_supply_chain_sales_analysis/blob/main/sql%20files/retail_supply_chain_sales_queries.sql))*

 ### Pyhton Scripts
- **Data Cleaning and EDA:** *([Link](https://github.com/kibiipatrick/retail_supply_chain_sales_analysis/blob/main/sql%20files/retail_supply_chain_sales_queries.sql))*
---

# Summary of Findings

### Key Insights
1. **Chairs and Phones** are the strongest-performing sub-categories by sales.

2. The average shipping duration is  **35 Days** across all years and shipping modes.

3. **California** consistently leads total sales, followed by New York and Texas.

4. A **Pareto (80/20)**  pattern exists, over 20% of sub-categories account for ~80% of total sales.More than 20% of Sub-Categories make up 80% of Sales as per the .

5.  **Tables and Supplies** have generated losses each year over the past four years.

---

# Insights Deep Dive

## **1. Market Distribution**
- California, New York, and Texas drive the majority of sales, along with many states in the East and South regions.

- Order volume begins rising in Q3, peaks in November, and slightly declines in December.

- Most products sell up to 30 units per year.

- The Consumer segment leads in both total sales and number of orders, while Home Office ranks third. 

![Sales Distribution Map](https://github.com/kibiipatrick/retail_supply_chain_sales_analysis/blob/main/screenshots/sales%20distribution%20map.png)

## **2. Product Performance**
- The **Canon imageCLASS 2200 Advanced Copier** appears frequently as a top-selling product in multiple months and years

- Clear performance differences exist across sub-categories, highlighting areas for portfolio optimization.


## **3. Sales Trends**
- Top-performing Sub-Categories by Sales:
  - **Phones**
  - **Chairs**
  - **Storage**
- Under-performing Sub-Categories:
  - **Tables**
  - **Bookcases**
  - **Supplies**
  - **Machines**
  Tables consistently generate the largest losses, recording approximately -$8K in 2017.

## **4. Shipping and Fulfilment Trends**
- The overall average shipping duration is 35 days.

- Significant variation exists across states, product categories, and shipping modes.

- Longer shipping times may correlate with lower customer satisfaction in some segments.

![Performance & Fullfilment Overview Dashboard](https://github.com/kibiipatrick/retail_supply_chain_sales_analysis/blob/main/screenshots/performance%20and%20fullfillment%20dashboard.png)

---

# Recommendations for Stakeholders

- Review or discontinue products in the **Tables & Supplies** sub-categories to reduce recurring losses. 
- Investigate orders that exceed **35 days** delivery time to identify bottlenecks.
- Prioritize inventory and marketing for high-performing products such as the **Canon imageCLASS 2200 Advanced Copier**.
- Aim for **<35 Days average Delivery time** to maximize customer satisfaction and retention.  


