# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_1;

use sql_project_1;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*) as total_sales from retail_sales;
select count(distinct customer_id) as total_sales from retail_sales;
select count(distinct category) as total_sales from retail_sales;

select * from retail_sales
where 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

delete fromm retail_sales
where
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales where sale_date="2022-11-5";
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022**:
```sql
select * from retail_sales 
where
	category="Clothing"
	and quantiy>=4 and
	sale_date >= '2022-11-01'
	and sale_date < '2022-12-01';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select 
		category, 
        sum(total_sale) as total_sales,
		count(*) as total_orders
	from retail_sales group by 1;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. **:
```sql
select 
	round(avg(age),2) as avg_age 
from 
	retail_sales 
where 
	category="Beauty" ;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select 
	* 
from 
	retail_sales
where 
	total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select 
category,
gender,
count(transactions_id) as total_transactions
from retail_sales
 group by 
 category,
 gender
 order by category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales.**:
```sql
select 
	customer_id,
    sum(total_sale) as Total_sale
from 
	retail_sales
group by customer_id
order by Total_sale desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
	category,
    count(distinct(customer_id)) as cnt_unique_cs
from
	retail_sales
group by
	category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17).**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.
 
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/ujwal-mendhe-0652b62ba/)
- **Github**: [Connect with me professionally](https://github.com/Ujwal0712)

Thank you for your support, and I look forward to connecting with you!
