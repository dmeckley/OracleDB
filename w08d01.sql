-----------------------------------------------------------------
/*
w08d01.sql
Dustin Meckley
ciss430 Database Systems
02/29/2016
*/ 
-- Subquery:
-----------------------------------------------------------------
-- Nested query inside another query:
-----------------------------------------------------------------
-- Q01: Which orders contain item RGAN01.
-----------------------------------------------------------------
SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

-----------------------------------------------------------------
-- Q02: Who ordered item RGAN01, display the cust_id. 
-----------------------------------------------------------------
SELECT cust_id
FROM Orders
WHERE order_num IN (20007, 20008);

-- or:

SELECT cust_id
FROM Orders
WHERE order_num IN(SELECT order_num
                   FROM OrderItems
                   WHERE prod_id IN 'RGAN01');

-----------------------------------------------------------------
-- Q03: List the names of the customers who ordered item RGN01
-----------------------------------------------------------------
SELECT cust_name
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN(SELECT order_num
                                     FROM OrderItems
                                     WHERE prod_id = 'RGAN01'));

-----------------------------------------------------------------
-- Q04: Which orders are placed after order_num 20007
-- List order_num, date, and cust_id. 
-----------------------------------------------------------------
SELECT *
FROM Orders
WHERE order_date > (SELECT order_date 
                    FROM Orders 
                    WHERE order_num = '20007');

-----------------------------------------------------------------
-- Q05: List all products that are priced higher than any
-- "teddy bear."
-----------------------------------------------------------------
SELECT prod_name, prod_price
FROM Products 
WHERE prod_price > (SELECT MIN(prod_price) 
                    FROM Products 
                    WHERE prod_name LIKE '%teddy bear%');
                    
-- or:

SELECT prod_name, prod_price
FROM Products 
WHERE prod_price > ANY (SELECT prod_price 
                        FROM Products 
                        WHERE prod_name LIKE '%teddy bear%');

-----------------------------------------------------------------
-- Q06: How many orders does each customer place?
-- List all customer names and the number of orders placed.
-----------------------------------------------------------------
SELECT cust_name, (SELECT COUNT(*) 	
                   FROM Orders 
                   WHERE orders.cust_id = customers.cust_id) 
                   AS "Number of Orders"
FROM Customers;

-----------------------------------------------------------------
-- Q07: List all product name and price for each vendor that is
-- priced above average of all product from that vendor.
-- Correlated Subqueries with p1 and p2 aliases (tuple variable).
-----------------------------------------------------------------
SELECT prod_name, prod_price, vend_id
FROM Products p1
WHERE prod_price > (SELECT AVG(prod_price) 
                    FROM Products p2
                    WHERE p1.vend_id = p2.vend_id);

-----------------------------------------------------------------
-- Q08: List product names and prices for the second highest
-- priced products assuming no tie is capable.
-- If only one product, won't show.
-----------------------------------------------------------------
SELECT prod_name, prod_price, vend_id
FROM Products p1
WHERE (SELECT COUNT(*) 
       FROM Products p2
       WHERE p2.prod_price > p1.prod_price) = 1;

