create database sql_project_1;

use sql_project_1;

show databases;

create table retail_sales(
	transactions_id int primary key,
    sale_date date,	
    sale_time time,	
    customer_id int,	
    gender varchar(15),	
    age int,	
    category varchar(15),	
    quantiy int,
    price_per_unit float,	
    cogs float,	
    total_sale float
);

select * from retail_sales
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or 
    category is null
    or 
    quantiy is null
    or
    price_per_unit
    or 
    cogs is null
    or 
    total_sale is null;

delete from retail_sales
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or 
    category is null
    or 
    quantiy is null
    or
    price_per_unit
    or 
    cogs is null
    or 
    total_sale is null;
    
-- DATA EXPLORATION:-

-- how many sales we have
select count(*) as total_sales from retail_sales;

-- how many unique customers we have
select count(distinct customer_id) as total_sales from retail_sales;

-- how many categories we have
select count(distinct category) as total_sales from retail_sales;

select distinct category  from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date="2022-11-5";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales 
where
	category="Clothing"
	and quantiy>=4 and
	sale_date >= '2022-11-01'
	and sale_date < '2022-12-01';
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
    select category, sum(total_sale) as total_sales,
    count(*) as total_orders
     from retail_sales group by 1;
 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 
select round(avg(age),2) as avg_age from retail_sales where category="Beauty" ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
category,
gender,
count(transactions_id) as total_transactions
from retail_sales
 group by 
 category,
 gender
 order by category
 ;  
 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year. 
select * 
from
(
 select
	extract(YEAR from sale_date) as year,
    extract(MONTH from sale_date) as month,
    avg(total_sale) as avg_sales,
    rank() over(partition by extract(YEAR from sale_date) order by avg(total_sale) desc ) as ranks
from retail_sales
group by 1,2
) as t1
where ranks=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
select 
	customer_id,
    sum(total_sale) as Total_sale
from 
	retail_sales
group by customer_id
order by Total_sale desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
	category,
    count(distinct(customer_id)) as cnt_unique_cs
from
	retail_sales
group by
	category;
    
    
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).
  with Hourly_sale
  as
  (
select *,
	case
		when extract(hour from sale_time)<12 then "morning"
        when extract(hour from sale_time) between 12 and 17 then "afternoon"
        else "evening"
        end as shift
	from retail_sales
    )
    select 
		shift,
        count(*) as Total_orders
	from Hourly_sale
    group by shift;
    
-- END OF PROJECT
    
    
    


    
    
    
    


