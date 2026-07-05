# Retail Inventory Analysis using PostgreSQL

## Project Overview

This project analyzes a retail inventory dataset from Zepto using PostgreSQL. The dataset, sourced from Kaggle, contains information about product categories, pricing, discounts, inventory levels, product weights, and stock availability.

The objective of this project is to perform Exploratory Data Analysis (EDA), clean the data, and answer real-world business questions related to inventory management, pricing strategies, discounts, and potential revenue. The analysis demonstrates how SQL can be used to transform raw retail data into meaningful business insights that support data-driven decision-making.

---

## Project Objectives

- Perform exploratory data analysis (EDA) on a retail inventory dataset.
- Clean and preprocess the dataset by handling invalid records.
- Analyze product pricing and discount patterns.
- Estimate potential revenue based on available inventory.
- Categorize products based on weight.
- Generate business insights to support inventory and pricing decisions.
- Demonstrate practical SQL skills using PostgreSQL.

---

## Tools & Technologies

- PostgreSQL
- SQL
- Kaggle Dataset 
- Git
- GitHub
 
---

## Dataset Information

**Dataset Name:** Zepto Inventory Dataset

**Source:** Kaggle

The dataset contains retail inventory information, including:

- Product Name
- Category
- MRP
- Discount Percentage
- Discounted Selling Price
- Available Quantity
- Product Weight
- Stock Availability


---

## Database Schema

The project uses a single table named **`zepto_products`**.

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| product_id | SERIAL | Unique identifier for each product |
| category | VARCHAR(100) | Product category |
| product_name | VARCHAR(255) | Name of the product |
| mrp | INT | Maximum Retail Price (converted to ₹ during cleaning) |
| discount_percent | INT | Discount offered on the product |
| available_quantity | INT | Quantity currently available in inventory |
| discounted_selling_price | INT | Selling price after discount (converted to ₹ during cleaning) |
| weight_in_grams | INT | Weight of one product in grams |
| out_of_stock | BOOLEAN | Indicates whether the product is out of stock |
| quantity | INT | Product quantity/unit information from the dataset |


---

## Exploratory Data Analysis (EDA)

Before performing business analysis, an exploratory data analysis (EDA) was conducted to understand the structure and quality of the dataset.

The following checks were performed:

- Determined the total number of records in the dataset.
- Checked for missing (NULL) values across all columns.
- Identified duplicate product names.
- Explored unique product categories.
- Analyzed stock availability (In Stock vs Out of Stock).
- Examined product pricing and discount information.
- Reviewed maximum and minimum values to understand data distribution.

---

## Data Cleaning

To improve data quality and ensure accurate analysis, the following cleaning steps were performed:

- Removed products with an MRP of 0, as these records contained invalid pricing information.
- Removed products with a weight of 0 grams because they could not be used for weight-based analysis.
- Converted price values from paise to Indian Rupees for better readability and meaningful business reporting.


---


## Business Questions Answered

The project answers several real-world business questions, including:

- FIND THE TOP-10 BEST VALUE PRODUCTS BASED ON THE DISCOUNT PERCENTAGE
- SHOW THE PRODUCTS WITH HIGH TO LOW MRP BUT OUT OF STOCK
- ESTIMATE THE MAXIMUM POTENTIAL REVENUE FOR EACH CATEGORY BASED ON THE DISCOUNTED SELLING PRICE AND THE CURRENT AVAILABLE STOCK.
- FIND ALL PRODUCTS WHERE MRP IS GREATER THAN 500rs AND discount < 10%
- IDENTIFY THE TOP 5 CATEGORIES OFFERING THE HIGHEST AVERAGE DISCOUNT PERCENTAGE
- FIND THE PRICE PER GRAM FOR PRODUCTS ABOVE 100g AND SORT BY BEST VALUE
- GROUP THE PRODUCTS IN TO CATEGORIES LIKE LOW, MEDIUM, BULK
- WHAT IS THE TOTAL INVENTORY WEIGHT PER CATEGORY?
