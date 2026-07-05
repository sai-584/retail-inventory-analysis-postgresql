-- ==========================================
-- PROJECT: Zepto Inventory Analysis
-- ==========================================

-- Database Creation

-- Data Import

-- Exploratory Data Analysis (EDA)

-- Data Cleaning

-- Business Questions

-- End of Project



CREATE TABLE zepto_products (
 	product_id SERIAL PRIMARY KEY,
    category VARCHAR(100),
    product_name VARCHAR(255),
    mrp INT,
    discount_percent INT,
    available_quantity INT,
    discounted_selling_price INT,
    weight_in_grams INT,
    out_of_stock BOOLEAN,
    quantity INT
);


/*IMPORT DATA */

COPY zepto_products(category,product_name,mrp,discount_percent,available_quantity,discounted_selling_price,weight_in_grams,out_of_stock,quantity)
FROM 'C:\temp\PROJECTS\SQL\Zepto project\Dataset\archive\zepto_utf8.csv'
CSV HEADER;


/* DATA EXPLORATORY ANALYSIS - EDA */

SELECT * FROM zepto_products;

--HOW MANY ROWS EXIST?
SELECT COUNT(*) FROM zepto_products;

--SHOW FIRST 10 ROWS
SELECT * FROM zepto_products LIMIT 10;

--NULL VALUES
SELECT * FROM zepto_products
WHERE category IS NULL
OR 
product_name IS NULL
OR 
mrp IS NULL
OR 
discount_percent IS NULL
OR 
available_quantity IS NULL
OR 
discounted_selling_price IS NULL
OR
weight_in_grams IS NULL
OR
out_of_stock IS NULL
OR
quantity IS NULL;

--SHOW DIFFERENT PRODUCT CATEGORIES
SELECT DISTINCT CATEGORY FROM zepto_products;

--COUNT PRODUCTS IN STOCK VS OUT OF STOCK
SELECT out_of_stock, COUNT(*) AS product_count FROM zepto_products
GROUP BY out_of_stock;

--COUNT PRODUCT NAMES PRESENT MULTIPLE TIMES
SELECT product_name, COUNT(*) AS productname_count FROM zepto_products
GROUP BY product_name HAVING COUNT(*) > 1 ORDER BY productname_count DESC;



/* DATA CLEANING */

--SHOW PRODUCTS WITH PRICE 0
SELECT * FROM zepto_products WHERE mrp = 0;
DELETE FROM zepto_products WHERE mrp = 0;

-- Remove products with invalid weight information (0 grams).
-- These records cannot be used for weight-based analysis such as
-- price per gram or product size classification.
DELETE FROM zepto_products
WHERE weight_in_grams = 0;

--CONVERT PAISE TO RUPEES
UPDATE zepto_products
SET mrp = mrp/100.0, discounted_selling_price = discounted_selling_price / 100.0;

SELECT mrp, discounted_selling_price FROM zepto_products;




/* BUSINESS QUESTIONS */

--FIND THE TOP-10 BEST VALUE PRODUCTS BASED ON THE DISCOUNT PERCENTAGE
SELECT product_name, mrp, discount_percent FROM zepto_products ORDER BY discount_percent DESC LIMIT 10;

--SHOW THE PRODUCTS WITH HIGH TO LOW MRP BUT OUT OF STOCK
SELECT product_name, mrp FROM zepto_products WHERE out_of_stock = True ORDER BY mrp DESC;

-- Estimate the maximum potential revenue for each category using the discounted selling price and the current available stock.
SELECT category, SUM(discounted_selling_price * available_quantity) AS estimated_revenue FROM zepto_products
GROUP BY category ORDER BY estimated_revenue DESC;

--FIND ALL PRODUCTS WHERE MRP IS GREATER THAN 500rs AND discount < 10%
SELECT product_name, category, mrp, discount_percent FROM zepto_products
WHERE mrp > 500 AND discount_percent < 10 ORDER BY mrp, discount_percent;

--IDENTIFY THE TOP 5 CATEGORIES OFFERING THE HIGHEST AVERAGE DISCOUNT PERCENTAGE
SELECT category, AVG(discount_percent) AS avg_discount FROM zepto_products 
GROUP BY category ORDER BY avg_discount DESC LIMIT 5;

--FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100g AND SORT BY BEST VALUE
SELECT product_name, discounted_selling_price::numeric / weight_in_grams AS price_per_gram
FROM zepto_products WHERE weight_in_grams > 100 ORDER BY price_per_gram;

--GROUP THE PRODUCTS IN TO CATEGORIES LIKE LOW, MEDIUM, BULK
SELECT *,
	CASE
		WHEN weight_in_grams <= 250 THEN 'Low'
		WHEN weight_in_grams <= 1000 THEN 'Medium'
		ELSE 'Bulk'
	END AS product_category FROM zepto_products;

--WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY?
SELECT category, SUM(weight_in_grams * available_quantity) AS inventory_weight FROM zepto_products
GROUP BY category ORDER BY SUM(weight_in_grams * available_quantity);