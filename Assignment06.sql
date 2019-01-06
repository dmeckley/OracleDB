-----------------------------------------------------------------
/*
Assignment06.sql
Dustin Meckley
ciss430 Database Systems
02/24/2016
*/ 
-----------------------------------------------------------------
-- Q01: What is the average order item price? 
-----------------------------------------------------------------
SELECT TO_CHAR(AVG(item_price), '$9,999,999.99')
AS "Average Order Item Price"
FROM OrderItems;

-----------------------------------------------------------------
-- Q02: How many vendors are domestic?
-----------------------------------------------------------------
SELECT COUNT(vend_country) 
AS "Number of Domestic Vendors"
FROM Vendors
WHERE vend_country = 'USA';

-----------------------------------------------------------------
-- Q03: List the largest amount spent on an order item in an 
-- order. For order 20005, order item #1, the amount is 
-- $1009.00.  For order 20006, the largest amount is $119.90. 
-- For order 20007, the largest amount is $574.50.  The question
-- asks what is overall largest amount.
-----------------------------------------------------------------
SELECT TO_CHAR(MAX(quantity * item_price), '$9,999,999.99') 
AS "Overall Largest Amount"
FROM OrderItems;

-----------------------------------------------------------------
-- Q04: What is the total sales amount?
-----------------------------------------------------------------
SELECT TO_CHAR(SUM(quantity * item_price), '$9,999,999.99')
AS "Total Sales Amount"
FROM OrderItems;

-----------------------------------------------------------------
-- Q05: List all orders, include number of items in the order,
-- and total cost of the order, sort total cost from high to low.
-- Format the currency with two decimal places and thousand 
-- separator.
-----------------------------------------------------------------
SELECT order_num, 
	   SUM(quantity) 
     AS quantity, 
	   TO_CHAR(SUM(quantity * item_price), '9,999.99') 
     AS total_cost
FROM OrderItems
GROUP BY order_num
ORDER BY total_cost DESC;
-----------------------------------------------------------------
-- Q06: Same as Q05 above, this time, we would like to ignore any
-- order item that contains less than 100 units. 
-----------------------------------------------------------------
SELECT order_num, 
	   SUM(quantity) 
     AS quantity, 
	   TO_CHAR(SUM(quantity * item_price), '9,999.99') 
     AS total_cost
FROM OrderItems
WHERE quantity >= 100
GROUP BY order_num
ORDER BY total_cost DESC;