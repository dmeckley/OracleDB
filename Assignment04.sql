/*----------------------
Dustin Meckley
CISS430 Database Systems
Assignment04.sql
*/----------------------

/* 
Q01: List all orders with order numbers by customers
1000000001 and 1000000005:
*/
SELECT order_num
FROM orders
WHERE cust_id = '1000000001' OR cust_id = '1000000005';

/* 
Q02: List all orders with order numbers by customers
1000000001 and 1000000005 during the first 15 days of  
February of 2012:
*/
SELECT order_num
FROM orders
WHERE (cust_id = '1000000001' OR cust_id = '1000000005')
AND order_date <= '15-Feb-12';

/* 
Q03: List all orders with order numbers that are not placed
during the first 15 days of February of 2012:
*/
SELECT order_num
FROM orders
WHERE NOT order_date BETWEEN '01-FEB-12' AND '15-FEB-12';

/* 
Q04: List all customer names if their name contains the word
Toy in their names:
*/
SELECT cust_name
FROM customers 
WHERE cust_name LIKE '%Toy%';

/* 
Q05: List all customer names if their state abbreviation's 
second letter is N:
*/
SELECT cust_name
FROM customers
WHERE cust_state LIKE '_N%';