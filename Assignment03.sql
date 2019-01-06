/*
Dustin Meckley 
ciss4320 Database Systems
Assignment03.sql
01/26/2016
*/

-- Q01: List all customer names alphabetically from a to z.
SELECT cust_name
FROM customers
ORDER BY cust_name;
-- or:
SELECT cust_name
FROM customers
ORDER BY cust_name ASC;

-- Q02: Find the contact, address, city, state, and zip for a customer named Fun4All.
SELECT cust_contact, cust_address, cust_city, cust_state, cust_zip
FROM customers
WHERE cust_name = 'Fun4All';

-- Q03: List all vendor names that do not provide a state name.
SELECT vend_name
FROM vendors
WHERE vend_state IS NULL;

-- Q04: List all vendor names that are not in the USA.
SELECT vend_name
FROM vendors
WHERE vend_country != 'USA';
-- or:
SELECT vend_name
FROM vendors
WHERE vend_country <> 'USA';

-- Q05: List all customer id who ordered in February 2012.
SELECT cust_id
FROM orders
WHERE order_date BETWEEN '01-FEB-12' AND '29-FEB-12';