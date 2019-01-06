-- w07d01.sql

-- Aggregate Functions with IGNORE NULL:
-----------------------------------------------------------------
-- Q01: What is the average price on all products 
-- in the products table?
SELECT TO_CHAR(AVG(prod_price), '999.99')
AS "Average"
FROM Products;

-----------------------------------------------------------------
-- Q02: How many customers do we have?
SELECT COUNT(*) 
AS "Count of All"
FROM Customers;
-- or:
SELECT COUNT(cust_name) 
AS "Number of Customer Names"
FROM Customers;
-- or:
SELECT COUNT(cust_email) 
AS "Number of Customer Email"
FROM Customers;

-----------------------------------------------------------------
-- Q03: How many vendors provide one or 
-- more products?
SELECT COUNT(DISTINCT vend_id)
AS "Vendors"
FROM Products;

-----------------------------------------------------------------
-- Q4: List the most expensive product price:
SELECT MAX(prod_price)
AS "Most Expensive"
FROM Products;

-----------------------------------------------------------------
-- Q5: What is the total number of units in order 20005?
SELECT SUM(quantity)
AS "Total Units"
FROM orderItems
WHERE order_num = 20005;

-----------------------------------------------------------------
-- Q6: What is the total price in order 20005?
SELECT TO_CHAR(SUM(quantity * item_price), '$9,999,999.99')
AS "TOTAL Price"
FROM orderItems
WHERE order_num = 20005;

-----------------------------------------------------------------
-- Q7: What is the total number of products and their average 
-- price in the products table?
SELECT COUNT(*)
AS "Number of Products", 
TO_CHAR(AVG(prod_price), '99999.99')
AS "Average Price"
FROM Products;