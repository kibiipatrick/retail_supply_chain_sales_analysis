USE retail_supply_chain_sales;

-- Create table
CREATE TABLE sales_orders (
    row_id INT NOT NULL,
    order_id VARCHAR(20) NOT NULL,
    order_date VARCHAR(30),
	ship_date VARCHAR(30),
    ship_mode VARCHAR(30),

    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(30),

    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(15),
    region VARCHAR(30),

    retail_sales_people VARCHAR(100),

    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),

    returned CHAR(1), -- Y / N
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),

    PRIMARY KEY (row_id)
)
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

-- Change Date format
ALTER TABLE  sales_orders
MODIFY COLUMN order_date VARCHAR(30),
MODIFY COLUMN ship_date VARCHAR(30);


SHOW VARIABLES LIKE 'secure_file_priv';

-- Import Data
LOAD DATA LOCAL INFILE '/Users/kibii/Documents/Data Analysis/End to End Projects/Retail Supply Chain Sales Analysis/Dataset/Retail-Supply-Chain-Sales-Dataset SQL.csv'
INTO TABLE sales_orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Preview Dataset
SELECT *
FROM sales_orders;

SELECT * 
FROM sales_orders
LIMIT 9990, 20;

-- Create Staging Table
CREATE TABLE  sales_orders_staging
LIKE sales_orders;

-- Copy Data to Staging Table
INSERT INTO sales_orders_staging
SELECT * 
FROM sales_orders;

-- Preview Staging Table 
SELECT *
FROM sales_orders_staging
LIMIT 5000,5;

-- Preview order_date Format
SELECT order_date,
str_to_date(order_date, '%d/%m/%Y') AS updated_date
FROM sales_orders_staging;

-- Preview ship_date Format
SELECT ship_date,
str_to_date(ship_date, '%d/%m/%Y') AS updated_date
FROM sales_orders_staging;

-- Convert String to Date
UPDATE sales_orders_staging
SET order_date = str_to_date(order_date, '%d/%m/%Y');

-- Convert String to Date
UPDATE sales_orders_staging
SET ship_date = str_to_date(ship_date, '%d/%m/%Y');

-- Update Date Columns Data Type
ALTER TABLE sales_orders_staging
MODIFY COLUMN order_date DATE,
MODIFY COLUMN ship_date DATE;

-- Types of Segments (Consumer, Corporate, Home Office)
SELECT DISTINCT(SEGMENT)
FROM sales_orders_staging;

-- Types of Shipping Modes
SELECT DISTINCT(ship_mode)
FROM sales_orders_staging;

-- Countries  (Only USA) Will Keep for Tableau Visualisation
SELECT DISTINCT(country)
FROM sales_orders_staging;

-- Check for Duplicate States  
SELECT DISTINCT(state)
FROM sales_orders_staging
ORDER BY state;

-- Check Distinct  Retail Sales People  
SELECT DISTINCT(retail_sales_people)
FROM sales_orders_staging
ORDER BY retail_sales_people;

-- Check Distinct  product names
SELECT COUNT(DISTINCT(product_name))
FROM sales_orders_staging;

-- Check for White Spaces in Product Names
SELECT COUNT(DISTINCT(TRIM(product_name)))
FROM sales_orders_staging;

-- Check for Null Values
SELECT * 
FROM sales_orders_staging
WHERE Order_ID IS NULL 
OR Order_Date IS NULL  
OR Ship_Date IS NULL 
OR Ship_mode IS NULL 
OR Customer_ID IS NULL 
OR Customer_Name IS NULL  
OR Segment IS NULL 
OR Country IS NULL 
OR City IS NULL 
OR State IS NULL 
OR Postal_Code IS NULL 
OR Region IS NULL 
OR Retail_Sales_people IS NULL  
OR Product_ID IS NULL 
OR Category IS NULL 
OR Sub_Category IS NULL 
OR Product_Name IS NULL 
OR Returned IS NULL 
OR Sales IS NULL
OR quantity IS NULL
OR discount IS NULL
OR profit IS NULL;

-- Check for Duplicate Values
WITH check_duplicates_cte AS (
SELECT order_id, ROW_NUMBER() OVER(PARTITION BY order_id, order_date, ship_date, ship_mode, customer_name, postal_code, product_id,returned) AS row_num
FROM sales_orders_staging
)
SELECT * 
FROM check_duplicates_cte
WHERE row_num > 1;

-- Double check the order IDs
SELECT * 
FROM sales_orders_staging
WHERE order_id = 'CA-2015-103135';

-- Check if more than One Customers share the same Order ID
WITH check_duplicates_cte_2 AS (
SELECT order_id, COUNT(DISTINCT(customer_id)) AS customer_count
FROM sales_orders_staging
GROUP BY order_id
)
SELECT * 
FROM check_duplicates_cte_2
WHERE customer_count > 1;

-- Check if more than One Customers share the same Name
WITH check_duplicate_customer_id_cte AS (
SELECT customer_id, COUNT(DISTINCT(customer_name)) AS customer_count
FROM sales_orders_staging
GROUP BY customer_id
)
SELECT * 
FROM check_duplicate_customer_id_cte
WHERE customer_count > 1;

--  Number of Orders per Customer
SELECT customer_id, COUNT(order_id) AS order_id_count
FROM sales_orders_staging
GROUP BY customer_id
ORDER BY order_id_count DESC;



