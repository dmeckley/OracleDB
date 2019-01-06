-----------------------------------------------------------------
/*
w08d03.sql
Dustin Meckley
ciss430 Database Systems
02/19/2016
*/ 
-----------------------------------------------------------------
-- Joining Tables Together:
-----------------------------------------------------------------
-- Q01: List all product names, their prices, and vendor names.
-----------------------------------------------------------------
SELECT prod_name, prod_price, vend_name
FROM Products JOIN Vendors
ON Products.vend_id = Vendors.vend_id;

-----------------------------------------------------------------
-- Q02: List all vendors, if a vendor supplies products.
-- Include their product names, and prices.
-- If a vendor does not supply anything, then put null
-- in the product names and prices.
-----------------------------------------------------------------
SELECT vend_name, prod_name, prod_price
FROM Products RIGHT JOIN Vendors
ON Products.vend_id = Vendors.vend_id;

-----------------------------------------------------------------
-- Q03: List all possible combinations of Vendors and Products.
-----------------------------------------------------------------
SELECT vend_name, prod_name, prod_price
FROM Vendors CROSS JOIN Products;

-----------------------------------------------------------------
-- Q04: What is the quantity sold for each product.
-- List the product name, quantity, and vendor name.
-----------------------------------------------------------------
SELECT Products.prod_name, Vendors.vend_name, SUM(quantity)
FROM Vendors JOIN Products
ON (Vendors.vend_id = Products.vend_id)
JOIN OrderItems
ON (Products.prod_id = OrderItems.prod_id)
GROUP BY Products.prod_name, Vendors.vend_name;

-----------------------------------------------------------------
-- Q05: Make a mailing list of address that includes both 
-- Vendors and Customers.
-----------------------------------------------------------------
SELECT vend_name AS name, 
	   vend_address AS address, 
	   vend_city AS city, 
	   vend_state AS state,
	   vend_zip AS zip,
	   vend_country AS vend_country
FROM Vendors
UNION
SELECT cust_name, 
       cust_address, 
       cust_city, 
       cust_state, 
       cust_zip, 
       cust_country
FROM Customers;
-----------------------------------------------------------------
-- Q06: Make a list with customer ID and if the customer is in 
-- the USA show yes; otherwise, show no.
-----------------------------------------------------------------
SELECT cust_id, 'Yes' AS domestic
FROM Customers
UNION
SELECT cust_id, 'No' AS domestic
FROM Customers
WHERE cust_country != 'USA';

-----------------------------------------------------------------
-- Q07: CREATE TABLE:
/* CREATE TABLE tableName
   (
   		columnName dataType columnAttribute
   		.
   		.
   		[Table Level Constraints]	
   )
*/
-----------------------------------------------------------------
CREATE TABLE invoice
(
	invoice_num NUMBER(10) NOT NULL,
	invoice_date DATE DEFAULT SYSDATE, 
	order_num NUMBER(10) NOT NULL,
	CONSTRAINT invoice_pk PRIMARY KEY (invoice_num),
	CONSTRAINT invoice_fk_orders FOREIGN KEY (order_num)
    REFERENCES orders(order_num) ON DELETE CASCADE
);

-----------------------------------------------------------------
-- Q08: DROP TABLE:
-----------------------------------------------------------------
DROP TABLE invoice;

