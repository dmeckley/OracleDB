-----------------------------------------------------------------
/*
w12d03.sql
Dustin Meckley
ciss430 Database Systems
04/06/2016
*/ 
-----------------------------------------------------------------
--                       Tables:
-----------------------------------------------------------------
-- Q01: Remove the new column "entered_by".
-----------------------------------------------------------------
ALTER TABLE Customers
DROP COLUMN entered_by;

-----------------------------------------------------------------
-- Q02: Remove the cust_id column from Customers table.
-----------------------------------------------------------------
ALTER TABLE Customers
DROP COLUMN cust_id;

CREATE TABLE Test
(
	id NUMBER(3), 
	name VARCHAR2(3),
	CONSTRAINT test_pk PRIMARY KEY(id)
);

INSERT INTO Test (id, name) 
VALUES (2, 'ABC');

SELECT * FROM Test;

/*
It is fine to drop an primary key of a table as long as it is not
a foreign key to another table.
*/
-----------------------------------------------------------------
-- Q03: Delete Customer with cust_id = '1000000005'.
-----------------------------------------------------------------
DELETE FROM Customers 
WHERE cust_id = '1000000005';

-- How to modify an foreign key constraint with two steps:
----------------------------------------------------------
-- 1) Drop Constraint.
ALTER TABLE Orders
DROP CONSTRAINT fk_orders_customers;
-- 2) Add Constraint.
ALTER TABLE Orders
ADD CONSTRAINT orders_fk_customers FOREIGN KEY(cust_id)
	REFERENCES Customers(cust_id)
	ON DELETE CASCADE;

-- Order table does not complain, but the OrderItems table
-- still needs Orders primary key
ALTER TABLE OrderItems
DROP CONSTRAINT fk_orderItems_orders;
ALTER TABLE OrderItems
ADD CONSTRAINT orderItems_fk_orders FOREIGN KEY (order_num)
	REFERENCES Orders(order_num)
	ON DELETE CASCADE;

ROLLBACK;

SELECT *
FROM Customers;

SELECT table_name, constraint_name, r_constraint_name
AS REFERENCES 
FROM user_constraints
WHERE constraint_type = 'R';

-----------------------------------------------------------------
--                     Views:
-----------------------------------------------------------------
-- Two types of views are regular view and materialized view.
-- When we say view, then we mean the regular type of view.
-- Virtual tables means not row, column only, so they are just 
-- stored queries.  
-- The advantages of utilizing views are:
-- 1) Views can be utilized and specified for various different 
--    users.
-- 2) It can be utilized for replacing subqueries.
-- 3) Provides one mor layer of security.
-----------------------------------------------------------------
-- Q04: What is the difference between a table and a view?
-----------------------------------------------------------------
CREATE TABLE tbleCustomer11 AS
SELECT * FROM Customers;

CREATE VIEW viewCustomer11 AS 
SELECT * FROM Customers;

SELECT * FROM tbleCustomer11;
SELECT * FROM viewCustomer11;
SELECT * FROM Customers;

-----------------------------------------------------------------
-- Q05: Insert a new customer
-----------------------------------------------------------------
--                 Table:
INSERT INTO tbleCustomer11(cust_id, 
						   cust_name, 
						   cust_address,
						   cust_city,
						   cust_state,
						   cust_zip,
						   cust_country,
						   cust_contact,
						   cust_email)
VALUES('1000000011', 
	   'Dustin Meckley', 
	   '23530 Audrain County Road 324',
	   'Mexico',
	   'MO',
	   '65265',
	   'USA',
	   '(573)721-1904',
	   'djmeckley1@cougars.ccis.edu');

--              View:
INSERT INTO viewCustomer11(cust_id, 
						   cust_name, 
						   cust_address,
						   cust_city,
						   cust_state,
						   cust_zip,
						   cust_country,
						   cust_contact,
						   cust_email)
VALUES('1000000011', 
	   'Dustin Meckley', 
	   '23530 Audrain County Road 324',
	   'Mexico',
	   'MO',
	   '65265',
	   'USA',
	   '(573)721-1904',
	   'djmeckley1@cougars.ccis.edu');

--            Original Table:
INSERT INTO Customers(cust_id, 
						   cust_name, 
						   cust_address,
						   cust_city,
						   cust_state,
						   cust_zip,
						   cust_country,
						   cust_contact,
						   cust_email)
VALUES('1000000011', 
	   'Dustin Meckley', 
	   '23530 Audrain County Road 324',
	   'Mexico',
	   'MO',
	   '65265',
	   'USA',
	   '(573)721-1904',
	   'djmeckley1@cougars.ccis.edu');

-----------------------------------------------------------------
-- Q06: Create a view showing all customers who ever bought the 
-- product "BR03".
-----------------------------------------------------------------
CREATE OR REPLACE VIEW br03_customers AS
SELECT C.cust_id, C.cust_name
FROM Customers C JOIN Orders O
ON C.cust_id = O.cust_id
JOIN OrderItems OI
ON O.order_num = OI.order_num
WHERE OI.prod_id = 'BR03';
-- Updateable view is aka key preserved view.

