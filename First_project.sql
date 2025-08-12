DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(20),
age INT,
category VARCHAR(20),
quantity INT,
price_per_unit FLOAT, 
cogs FLOAT,
total_sale FLOAT
)
SELECT
COUNT(*)
FROM retail_sales;

select * from retail_sales
where
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

	 delete from retail_sales
where
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--How many sales we have
select count(*) as total_sales from retail_sales;
-- How many unique customers we have
select count(distinct customer_id) as total_count from retail_sales;
--unique category
select distinct category from retail_sales;

--What are the sales on 2022-11-05?
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--For category Clothing, which November 2022 sales had quantity ≥ 4?
SELECT 
      *
FROM retail_sales
WHERE category='Clothing'
AND
   TO_CHAR(sale_date, 'YYYY-MM')='2022-11'
AND
   quantity >=4
GROUP BY 1;

--What is the total sales amount and total orders per category?
SELECT
     category,
   SUM(total_sale) AS net_sale,
   COUNT (*) AS total_orders
FROM retail_sales
GROUP BY 1;

--What is the average age of customers for category Beauty?
SELECT  
   ROUND(AVG(age),3) AS Average_Age
FROM retail_sales
WHERE category='Beauty';

--Which sales have total_sale > 1000?
SELECT * FROM retail_sales
WHERE total_sale>1000;

--How many transactions per category and gender?
SELECT 
     category,
	 gender,
     COUNT(*) AS Total_Transaction
FROM retail_sales
GROUP BY 
       category,
	   gender
ORDER BY category


--Which month in each year had the highest average sales?;
SELECT * FROM
(
 SELECT 
     EXTRACT(YEAR FROM sale_date) AS year,
	 EXTRACT(MONTH FROM sale_date) AS month,
	 AVG(total_sale) AS Avg_Sale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) AS rank
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank=1
--ORDER BY 1,3 DESC;

--Who are the top 5 customers by total sales?
SELECT 
     customer_id,
	 SUM(total_sale) AS Total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--How many distinct customers per category?
SELECT 
     category,
     COUNT(DISTINCT customer_id)	 
FROM retail_sales
GROUP BY 1;

--How many transactions occurred in the morning, afternoon, and evening?
WITH hourly
AS(
SELECT *,
     CASE
	     WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		 WHEN EXTRACT(HOUR FROM sale_time)BETWEEN 12 AND 17 THEN 'Afternoon'
		 ELSE 'Evening'
	 END AS Shift
  FROM retail_sales
)
SELECT
     Shift,
	 COUNT(*) AS Transaction_id
FROM hourly
GROUP BY Shift


