-- Contatenation of fields (||):

-- Q01: Show all vendor names with thier
-- corresponding country in parantheses:
-- Ex: Bears R Us (USA)
SELECT vend_name || ' (' || vend_country || ')'
FROM vendors;

-----------------------------------------------------------------
-- Using aliases (AS):

-- Q02: Name the column of the previous one 
-- with "vend_title":
SELECT vend_name || ' (' || vend_country || ')'
AS vend_title
FROM vendors;

-- Calculated fields:

-- Q03: Calculate the total price for each order item
-- in the order 20009:
SELECT order_item, quantity, item_price, 
quantity * item_price AS "Total Price"
FROM orderItems
WHERE order_num = 20009;

-----------------------------------------------------------------
-- TO_CHAR function:

-- Q04: Show the order number and order date in the 
-- following format:
-- Ex: Order Number = 20005, dated = 05/01/2012
SELECT 'Order Number: ' || order_num || ', dated: '
|| TO_CHAR(order_date, 'mm/dd/yyyy')
AS "Order Text"
FROM orders;

-- Q05: Correct Q03 with two decimal places:
SELECT order_item, quantity, item_price, 
TO_CHAR(quantity * item_price, '999,999.99') AS "Total Price"
FROM orderItems
WHERE order_num = 20009; 

-- Some more examples of TO_CHAR function implementation:
SELECT TO_CHAR(order_date, 'DD-MON-YYYY HH:MI:SS AM')
FROM orders;

-----------------------------------------------------------------
-- CAST Function:
-- For type casting one data type to another.
SELECT order_item, quantity, item_price, 
CAST(quantity * item_price AS NUMBER(7)) AS "Total Price"
FROM orderItems
WHERE order_num = 20009;

-----------------------------------------------------------------
-- UPPER/LOWER Function:
-- For converting to uppercase or lowercase.
SELECT LOWER(order_date)
FROM orders;

-----------------------------------------------------------------
-- SUBSTR Function:
-- Substring function
-- SUBSTR(vend_name, minLength, maxLength)
SELECT SUBSTR(vend_name, 1, 5)
FROM vendors;

-----------------------------------------------------------------
-- INSTR Function:
-- Instring Function
-- INSTR(vend_name, 'itemToLookFor', numberOfIndexLocation)

-- Q06: Display the second words in an vendor's name:
-- INSTR(vendor_name, ' ', n, 2) return the position
-- of the second space beginning at postition n:
SELECT
CASE
  WHEN INSTR(vend_name, ' ') = 0
  THEN NULL
  WHEN INSTR(vend_name, ' ', 1, 2) = 0 
  THEN SUBSTR(vend_name, INSTR(vend_name, ' ') + 1)
  WHEN INSTR(vend_name, ' ', 1, 2) > 0 
  THEN SUBSTR(vend_name, INSTR(vend_name, ' ') + 1, 
  INSTR(vend_name, ' ', 1, 2) - INSTR(vend_name, ' ', 1, 1) - 1) 
  END AS "Second word of the vendor name"
  FROM vendors;
  
-- Q07: List all customers with customer name that contains 
-- exactly two words:
SELECT *
FROM customers
WHERE REGEXP_LIKE(cust_name, '^[^ ]+[ ]+[^ ]+$');

-- Q08: List the second word of customer address:
SELECT REGEXP_SUBSTR(cust_address,'[^ ]+', 1, 2)
FROM customers;

-- Q09: List all the customers with a customer name of 3 or 
-- more words:
SELECT *
FROM customers
WHERE REGEXP_INSTR(cust_name, '[^ ]+', 1, 3) > 0;

-- Q10: List all customers with one or more digits
-- in their names:
SELECT *
FROM customers
WHERE REGEXP_LIKE(cust_name, '\d+');

-----------------------------------------------------------------
-- REPLACE Function:
-- Replace Function
/*
REPLACE(vend_country, itemToFind, valueToReplaceItemFoundWith)
*/

-- Q11: List all vendors with their country names as
-- United States of America as it it is USA:
SELECT REPLACE(vend_country, 'USA', 'United States of America')
FROM vendors;