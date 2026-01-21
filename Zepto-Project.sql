CREATE DATABASE IF NOT EXISTS zepto_sql;
USE zepto_sql;

-- Here Import dataset from browser and create table 
-- column MRP and discountedSellingPrice are in paisa so after calculation u need to divide bby 100 for find in rupee

-- Table & Columns Check

-- Check tables in the database
SHOW TABLES;

-- Check column names and types
DESCRIBE zepto_details;

-- Preview data
SELECT * FROM zepto_details LIMIT 10;

-- Basic Data Understanding
-- Total products

SELECT COUNT(*) AS total_products
FROM zepto_details;

-- Total categories

SELECT COUNT(DISTINCT Category) AS total_categories
FROM zepto_details;

-- Products per category

SELECT Category, COUNT(*) AS product_count
FROM zepto_details
GROUP BY Category
ORDER BY product_count DESC;

-- Category list

SELECT DISTINCT Category
FROM zepto_details;


-- Preview top products by quantity

SELECT name, quantity
FROM zepto_details
ORDER BY quantity DESC
LIMIT 10;

-- Pricing Analysis

--  Average MRP vs Discounted Price

SELECT 
    ROUND(AVG(mrp),2) AS avg_mrp,
    ROUND(AVG(discountedSellingPrice),2) AS avg_discounted_price
FROM zepto_details;


-- Top 10 products with highest discounts (absolute value)

SELECT name, mrp, discountedSellingPrice, 
       (mrp - discountedSellingPrice) AS discount_amount
FROM zepto_details
ORDER BY discount_amount DESC
LIMIT 10;


-- Top 10 products with highest discount percentage

SELECT name, Category, discountPercent
FROM zepto_details
ORDER BY discountPercent DESC
LIMIT 10;


-- Average discount % per category

SELECT Category, ROUND(AVG(discountPercent),2) AS avg_discount_percent
FROM zepto_details
GROUP BY Category
ORDER BY avg_discount_percent DESC;


-- Products with high discounts (>20%)

SELECT name, Category, discountPercent
FROM zepto_details
WHERE discountPercent > 20
ORDER BY discountPercent DESC;

-- Business Questions
-- Q1 Total Product Count & Category Insights
Select count(name) AS Product_count,category from zepto_details group by(Category);

-- Q2 Average Pricing Strategy
select AVG(mrp) AS AVG_MRP_In_Paisa , avg(discountedSellingPrice) AS AVG_SELLINGPRICE_In_Paisa from zepto_details;

-- Q3 Top Discounted Products
SELECT 
    name,
    mrp,
    discountedSellingPrice,
    (mrp - discountedSellingPrice) AS discount_amount
FROM zepto_details
ORDER BY discount_amount DESC
LIMIT 10;

-- Q4 Average Discount per Category
SELECT 
    category,
    ROUND(AVG(discountpercent),2) AS avg_discount_percent
FROM zepto_details
GROUP BY category
ORDER BY avg_discount_percent DESC;

-- Q5 Out-of-Stock Products Count

SELECT COUNT(*) AS outOfStock
FROM zepto_details
WHERE outOfStock = 'TRUE';

-- Q6 Category-wise Out-of-Stock Products

SELECT category, COUNT(*) AS out_of_stock_count
FROM zepto_Details
WHERE outofstock = 'TRUE'
GROUP BY category
ORDER BY out_of_stock_count DESC;


-- Q7 High Quantity Products

SELECT name, quantity
FROM zepto_details
ORDER BY quantity DESC
LIMIT 10;

--  Low Stock Alert

-- Q8: Available quantity kam (<5) wale products kaunse hain?


SELECT name, availableQuantity
FROM zepto_details
WHERE availableQuantity <5
ORDER BY availableQuantity ASC;





