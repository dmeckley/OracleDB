-- w07d03.sql

-- Returning by Group instead of Returning by Rows:
-----------------------------------------------------------------

-- Q01: How many products does each vendor supply?
-----------------------------------------------------------------
SELECT vend_id, COUNT(*) 
AS "Number of Products"
FROM Products
GROUP BY vend_id;

-- Q02: List all customers who place one or more order:
-----------------------------------------------------------------
SELECT cust_id, COUNT(*) 
AS "Number of Orders"
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) > 1;

-- Q03: List all vendors who have 2 or more products priced at
-- $4.00 or more
-----------------------------------------------------------------
SELECT vend_id, COUNT(*)
FROM Products
WHERE prod_price >= 4.00
GROUP BY vend_id
HAVING COUNT(*) >= 2;

-- Q04: List all vendors who have 2 or more products priced at 
-- $4.00 or more and ordered by the number of products
-----------------------------------------------------------------
SELECT vend_id, COUNT(*)
AS itemCount
FROM Products
WHERE prod_price >= 4.00
GROUP BY vend_id
HAVING COUNT(*) >= 2
ORDER BY itemCount;