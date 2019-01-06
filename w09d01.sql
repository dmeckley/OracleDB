-----------------------------------------------------------------
/*
w09d01.sql
Dustin Meckley
ciss430 Database Systems
03/00/2016
*/ 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Q01: Find all vendors which is from the same country and their
-- same county as Bears R US.  List their names.
-----------------------------------------------------------------
SELECT vend_name
FROM Vendors
WHERE vend_country = (SELECT vend_country
					  FROM Vendors
					  WHERE vend_name = 'Bears R Us');

-----------------------------------------------------------------
-- Q02: Find all vendors which is from the same country and their
-- same county as Bears R US.  List their names. Use the joining
-- of tables to do the same thing as in Q01.
-----------------------------------------------------------------
SELECT V1.vend_name
FROM Vendors V1 JOIN Vendors V2
ON V1.vend_country = V2.vend_country
WHERE V2.vend_name = 'Bears R Us';

-----------------------------------------------------------------
-- Q03: Self-join example.
-- The creation of a table called EMPLOYEE2 from D2L - March 7th. 
-----------------------------------------------------------------
-- Self join codes
CREATE TABLE employee2
(
emp_id NUMBER(3) NOT NULL,
emp_name VARCHAR(10) NOT NULL,
mgr_id NUMBER(3),
CONSTRAINT employee2_pk PRIMARY KEY (emp_id),
CONSTRAINT employee2_fk_employee2 FOREIGN KEY (mgr_id) 
REFERENCES employee2 (emp_id)
);

-- Populate the table:
INSERT INTO employee2 (emp_id, emp_name, mgr_id) 
VALUES (102, 'Bob', NULL);
INSERT INTO employee2 (emp_id, emp_name, mgr_id) 
VALUES (103, 'Chuck', NULL);
INSERT INTO employee2 (emp_id, emp_name, mgr_id) 
VALUES (101, 'Alice', 102);
INSERT INTO employee2 (emp_id, emp_name, mgr_id) 
VALUES (104, 'Dan', 103);
INSERT INTO employee2 (emp_id, emp_name, mgr_id) 
VALUES (105, 'Ellen', 102);

-- Testing the table:
SELECT * FROM employee2;
-----------------------------------------------------------------
-- Q03-1: List all employees and their manager's name subquery. 
-----------------------------------------------------------------
SELECT emp_name,
       (SELECT emp_name FROM employee2 E2
        WHERE E1.mgr_id = E2.emp_id) AS Manager
FROM employee2 E1
--WHERE (SELECT emp_name 
       --FROM employee2 E2 
       --WHERE E1.mgr_id = E2.emp_id) IS NOT NULL
WHERE E1.mgr_id IS NOT NULL;
       
-----------------------------------------------------------------
-- Q03-2: List all employees and their manager's name with join. 
-----------------------------------------------------------------
SELECT E1.emp_name, E2.emp_name
FROM employee2 E1 JOIN employee2 E2
ON E1.mgr_id = E2.emp_id;      

-----------------------------------------------------------------
-- Drop the table. 
-----------------------------------------------------------------
DROP TABLE employee2;

-----------------------------------------------------------------
-- Q04: List customers who placed orders. List customer names and
-- number of orders placed. 
-----------------------------------------------------------------
SELECT cust_name, orderCount
FROM (SELECT C.cust_name, COUNT(order_num) AS orderCount
	    FROM Customers C JOIN orders
	    ON C.cust_id = orders.cust_id
	    GROUP BY C.cust_id, C.cust_name);

-----------------------------------------------------------------
-- Q05: Show Village Toys order history showing order date,
-- products in that order and their quantities and item prices
-- sort from most recent first.
-----------------------------------------------------------------
SELECT order_date, prod_name, quantity, item_price
FROM Customers JOIN Orders
ON Customers.cust_id = Orders.cust_id
JOIN OrderItems
ON Orders.order_num = OrderItems.order_num
JOIN Products
ON OrderItems.prod_id = Products.prod_id
WHERE Customers.cust_name = 'Village Toys'
ORDER By Orders.order_date DESC;

