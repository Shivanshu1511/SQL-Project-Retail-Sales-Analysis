-- SQL Queries for the Projects 
-- Create Table

Use sql_project1;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
            
 desc retail_sales;
 Select * from retail_sales;
 Select 
 count(*)
 from retail_sales;
 
 -- Data Cleaning 
 
 Select * From retail_sales 
 where transaction_id Is Null;
 
 SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    -- No data Found for the above query so there is nothing to clean
    
    -- Data Exploration 
    -- How many sales we have
    
Select Count(*)as Total_Sales from retail_sales;

   -- How many uniuque customers we have ?
   
   Select  Count(distinct(customer_id))as total_customers from retail_sales;
   
   
   -- New SQL Analysis & Business Questions

-- Q1) Daily Sales Report – Write a SQL query to retrieve all columns for sales made on '2022-07-09'.
-- Q2) High-Value Electronics – Retrieve all transactions where the category is 'Electronics' and total_sale is greater than 2000 in December 2022.
-- Q3) Monthly Revenue by Category – Calculate the total sales for each category for July 2022.
-- Q4) Young Customer Insights – Find the average total_sale for customers under age 30 who purchased items from 'Clothing'.
-- Q5) Bulk Orders – Retrieve transactions where quantiy is greater than 8 and category is 'Beauty'.
-- Q6) Top Category by Gender – Find the total number of transactions for each gender in each category, and identify the category with the maximum sales for female customers.
-- Q7) Profit Calculation – Calculate total profit for each category, where profit = total_sale - cogs.
-- Q8) Peak Sales Hour – Find the hour of the day with the highest number of transactions.
-- Q9) Customer Repeat Purchases – Find customers who made more than 3 transactions in November 2022.
-- Q10) Average Order Value per Category – Calculate the average total_sale per category, and rank categories from highest to lowest.
   
 -- Q1) Daily Sales Report – Write a SQL query to retrieve all columns for sales made on '2022-07-09'.
 
 Select * from retail_sales where sale_date ='2022-07-09';
 
 -- Q2) High-Value Electronics – Retrieve all transactions where the category is 'Electronics' and total_sale is greater than 2000 in December 2022.
 
 Select transaction_id from retail_sales where category ='Electronics' and total_sale >2000 and year(sale_date) ='2022';
 
 -- Q3) Monthly Revenue by Category – Calculate the total sales for each category for July 2022.
 
 Select category,  sum(total_sale)as total_Sales from retail_sales group by category;
 
 -- Q4) Young Customer Insights – Find the average total_sale for customers under age 30 who purchased items from 'Clothing'.
 
 Select age ,Avg(total_sale) as Avg_Sale, category  from retail_sales where age<30 and category = 'Clothing'  group by age order by age;
 
 -- Q5) Bulk Orders – Retrieve transactions where quantiy is greater than 8 and category is 'Beauty'.
 
 select * from retail_sales where  quantity >8 and category = 'Beauty';
 
 -- Q6) Top Category by Gender – Find the total number of transactions for each gender in each category, and identify the category with the maximum sales for female customers.
 
Select count(transaction_id) as total_transaction, gender, category from retail_sales WHERE gender = 'Female' group by gender, category ORDER BY count(transaction_id) DESC
LIMIT 1;

-- Q7) Profit Calculation – Calculate total profit for each category, where profit = total_sale - cogs.
Select category, sum(total_sale -cogs)as profit from retail_sales group by category;

-- Q8) Peak Sales Hour – Find the hour of the day with the highest number of transactions.
SELECT 
    EXTRACT(HOUR FROM sale_time) AS sale_hour,
    COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY sale_hour
ORDER BY COUNT(transaction_id)  DESC
LIMIT 1;

-- Q9) Customer Repeat Purchases – Find customers who made more than 3 transactions in November 2022.

select count( transaction_id)as total_transcation, customer_id from retail_sales group by  customer_id having count( transaction_id)>3;

-- Q10) Average Order Value per Category – Calculate the average total_sale per category, and rank categories from highest to lowest.

Select avg(total_sale)as Avg_total_Sale, category from retail_sales group by category order by avg(total_sale) desc;

 