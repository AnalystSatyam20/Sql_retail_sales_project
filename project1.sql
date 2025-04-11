CREATE DATABASE sql_project_s1;
use sql_project_s1;
-- creating table
CREATE TABLE retail(
transactions_id int primary key,
sale_date Date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(30),
quantity int,
price_per_unit float,
cogs float,
total_sale float
);

-- deleting the null values from record
delete  from retail where cogs is null;

-- question 1-> write a sql query to retreive all columns for sales made on '2022-11-05'
select * from retail where sale_date='2022-11-05' ;

-- question2-> write a sql query to retreive all transactions where the catgeory is'clothing' and the quantity sold is more than 4
select * from retail where category='Clothing' And sale_date>='2022-11-01' and sale_date <='2022-11-30' AND quantity=4;

-- question3->Write a sql query to calculate the total sales (total_sale) for each category
select category,sum(total_sale) as net_sale  from retail group by 1 ;

-- question4-> Write a sql query to find the average age of customers who purchased items from the beauty category
select avg(age) from retail where category='Beauty';

-- question5-> Write a Sql query to find all transactions where the total_sale is greater than 1000
select * from retail where total_sale>1000;

-- Question 6-> Write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.
Select gender,category, count(transactions_id) as total_transactions from retail as total_transactions group by category,gender;

-- Question 7->Write a sql query to calculate the average sale for each month and rank them in descending order according to average sale.
select Extract(year from sale_date) as year,Extract(month from sale_date)as month,avg(total_sale) from retail group  by 1,2 order by 1,3 desc;


-- Question 8->Write a sql query to find the top 5 customers based on highest total sales
select customer_id,sum(total_sale) as total_sale from retail group by customer_id order by total_sale desc limit 5;

-- Question 9->Write a Sql Query to find the number of unique customers who purrchased items from different category.
select count(distinct customer_id),category from retail group by category;

-- question 10->Write a sql query to create each shift and number of orders(Example Morning<=12,Afternoon between 12 & 17,Evening >17.
with hourly_sale
as
(
select *,
case 
when sale_time<'12:00:00' then 'Morning'
when sale_time between '12:00:01' and '18:00:00' then 'after noon'
else 'Evening'
end as shift
from retail
)
select shift, count(*) as total_orders from hourly_sale group by shift;
