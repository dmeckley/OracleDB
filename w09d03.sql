-----------------------------------------------------------------
/*
w09d03.sql
Dustin Meckley
ciss430 Database Systems
03/09/2016
*/ 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Q01: Which products and how many unit of each are sold during
-- the first month of 2012?
-----------------------------------------------------------------
SELECT prod_name, SUM(quantity)
FROM Products JOIN OrderItems
ON Products.prod_id = OrderItems.prod_id
JOIN Orders 
ON OrderItems.order_num = Orders.order_num
WHERE Orders.order_date BETWEEN '01-JAN-12' AND '31-JAN-12'
GROUP BY prod_name;

-----------------------------------------------------------------
-- Q02: List all customers from IL, IN, and MI.  Show customer 
-- name, contact, and email.
-----------------------------------------------------------------
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN('IL', 'IN', 'MI');

-----------------------------------------------------------------
-- Q03: List all customers called "Fun4All". Show customer name,
-- contact, and email.
-----------------------------------------------------------------
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

-----------------------------------------------------------------
-- Q04: Show all tuples in the previous two queries.
-- The duplicate tuples are eliminated.
-----------------------------------------------------------------
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';


-----------------------------------------------------------------
-- Q05: List the total sales revenue for the first month of 2012?
-----------------------------------------------------------------
SELECT 'January' AS Month, TO_CHAR(SUM(quantity * item_price),
'99,999.99') AS "Total Sales"
FROM OrderItems JOIN Orders
ON orderItems.order_num = Orders.order_num
WHERE order_date BETWEEN '1-JAN-12' AND '31-JAN-12'
GROUP BY 'January';

-----------------------------------------------------------------
-- Q06: List the total sales revenue for the first two months of 
-- 2012?
-----------------------------------------------------------------
SELECT 'January' AS Month, TO_CHAR(SUM(quantity * item_price),
'99,999.99') AS "Total Sales"
FROM OrderItems JOIN Orders
ON orderItems.order_num = Orders.order_num
WHERE order_date BETWEEN '1-JAN-12' AND '31-JAN-12'
GROUP BY 'January'
UNION ALL
SELECT 'February' AS Month, TO_CHAR(SUM(quantity * item_price),
'99,999.99') AS "Total Sales"
FROM OrderItems JOIN Orders
ON orderItems.order_num = Orders.order_num
WHERE order_date BETWEEN '1-FEB-12' AND '28-FEB-12'
GROUP BY 'February';


