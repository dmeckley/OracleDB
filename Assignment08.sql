-----------------------------------------------------------------
/*
Assignemnt08.sql
Dustin Meckley
ciss430 Database Systems
03/14/2016
*/ 
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Q01: Find all customers with the same name.
-- List their names and addresses.  
-----------------------------------------------------------------
SELECT C1.cust_name, C1.cust_address
FROM Customers C1 JOIN Customers C2
ON C1.cust_name = C2.cust_name
WHERE C1.cust_address != C2.cust_address;

-----------------------------------------------------------------
-- Q02: List customer names and amount each spent during the 2nd 
-- month of 2012.
-----------------------------------------------------------------
SELECT C.cust_name, 
	   TO_CHAR(SUM(OI.quantity * OI.item_price), '$999,999.99')
	   AS "Amount Spent"
FROM Customers C, Orders O, OrderItems OI 
WHERE C.cust_id = O.cust_id
AND O.order_num = OI.order_num
AND O.order_date LIKE '%FEB-12'
GROUP BY C.cust_name;

-----------------------------------------------------------------
-- Q03: Show Village Toys order history.  Show the order date,
-- products in that order, the quantities of the products, the 
-- items prices, and the item total for each product for the 
-- customer Village Toys.  Sort the results by most recent first.
-----------------------------------------------------------------
SELECT order_date, prod_name, quantity, item_price,
	   TO_CHAR(SUM(quantity * item_price), '$999,999.99') AS Total
FROM Customers JOIN Orders
ON Customers.cust_id = Orders.cust_id
JOIN OrderItems
ON Orders.order_num = OrderItems.order_num
JOIN Products
ON OrderItems.prod_id = Products.prod_id
WHERE Customers.cust_name = 'Village Toys'
GROUP BY order_date, prod_name, quantity, item_price
ORDER BY order_date DESC;

-----------------------------------------------------------------
-- Q04: What products and how many units of each are sold since
-- March first 2012?  List all product names and their quantities
-- sold.  
-----------------------------------------------------------------
SELECT prod_name, SUM(quantity)
FROM Products JOIN OrderItems
ON Products.prod_id = OrderItems.prod_id
JOIN Orders 
ON OrderItems.order_num = Orders.order_num
WHERE Orders.order_date BETWEEN '01-MAR-12' AND '31-DEC-12'
GROUP BY prod_name;

-----------------------------------------------------------------
-- Q05: Make a mailing list of address that includes both vendors
-- and customers.  The list should include name, address, city,
-- state, zip code, adn country.
-----------------------------------------------------------------
SELECT cust_name AS NAME, 
	   cust_address AS ADDRESS, 
	   cust_city AS CITY, 
	   cust_state AS STATE, 
	   cust_zip AS zip,
	   cust_country AS COUNTRY 
FROM Customers
UNION ALL 
SELECT vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country 
FROM Vendors
ORDER BY NAME;


