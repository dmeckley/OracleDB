/* 
Assignment02.sql
Dustin Meckley
ciss430 Database Systems
1/20/2016
*/

-- Q01: List all customer name, address, city, state, and country.
SELECT cust_name, cust_address, cust_city, cust_state, cust_country
FROM customers;

/* 
Q02: List all customers who placed an order with customer id. 
A customer who places multiple orders should only show up once.
*/
SELECT DISTINCT cust_id
FROM orders;

-- Q03: List any 3 vendors with vendor id and name.
SELECT vend_id, vend_name 
FROM vendors
WHERE ROWNUM <= 3;