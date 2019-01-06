-----------------------------------------------------------------
/*
w11d01.sql
Dustin Meckley
ciss430 Database Systems
03/21/2016
*/ 
-----------------------------------------------------------------
-- Q01: Make a copy of Customers table for practice.
-----------------------------------------------------------------
CREATE TABLE Customers1 
AS SELECT * 
FROM Customers;

-----------------------------------------------------------------
-- Q02: Change table for practice.
-----------------------------------------------------------------
ALTER TABLE Customers1
MODIFY cust_country VARCHAR2(50) DEFAULT 'USA'

-----------------------------------------------------------------
-- INSERT Statement Syntax:
-- INSERT INTO TableName(column1, column2, etc...)
-- VALUES (value1, value2, etc...)

-- Not all column value pairs have to appear.  You can use 
-- DEFAULT, or NULL in place of values.
-----------------------------------------------------------------
-- Q03: Add an newer customer to the Customers1 table.
-----------------------------------------------------------------
INSERT INTO Customers1(cust_id, 
					             cust_name, 
					             cust_address,
					             cust_city,  
					             cust_state, 
					             cust_zip, 
					             cust_country,
					             cust_contact,
					             cust_email)
VALUES ('1000000006', 
	      'Toy Land', 
	      '123 Any Street', 
	      'New York', 
	      'NY', 
	      '11111', 
	      DEFAULT, 
	      NULL, 
	      NULL);

SELECT * 
FROM Customers1;

-----------------------------------------------------------------
-- UPDATE Statement Syntax:
-- UPDATE TableName
-- SET column1 = 'New Value1', column2 = 'New Value2'
-- WHERE condition
-----------------------------------------------------------------
-- Q04: Update contact, email for customer 1000000005, use 
-- Customers1 table.
-----------------------------------------------------------------
UPDATE Customers1
SET cust_contact = 'Dustin Meckley',
	  cust_email = 'djmeckley1@cougars.ccis.edu'
WHERE cust_id = '1000000005';

SELECT * 
FROM Customers1;

-----------------------------------------------------------------
-- DELETE Statement Syntax:
-- DELETE
-- FROM TableName
-- WHERE condition
-----------------------------------------------------------------
-- Q05: Delete the customer with id of 1000000006 from Customers1
-- table.
-----------------------------------------------------------------
DELETE 
FROM Customers1
WHERE cust_id = '1000000006';

SELECT *
FROM Customers1;

-----------------------------------------------------------------
-- Q06: Delete the customer with id of 1000000001 from Customers
-- table.
-----------------------------------------------------------------
DELETE 
FROM Customers
WHERE cust_id = '1000000001';

-----------------------------------------------------------------
-- Q07: Delete the email address for customer 1000000005 from
-- Customers1 table without removing the whole record.
-----------------------------------------------------------------
UPDATE Customers1
SET cust_email = NULL
WHERE cust_id = '1000000004';

SELECT *
FROM Customers1;

ROLLBACK;

-----------------------------------------------------------------
-- Transaction: a group of queries which is all or nothing.
-----------------------------------------------------------------
-- Q08: Customer 1000000005 places an order on 1-JUN-12 with 
-- 10 units of BR01 at 7.99 each and 20 units of BR03 at 11.99
-- each.  Insert the records into database. 
-----------------------------------------------------------------
DECLARE
  myException EXCEPTION;
  
BEGIN
  SAVEPOINT start_transaction;
  
  INSERT INTO Orders(order_num, order_date, cust_id)
  VALUES (20010, '1-Jun-12', '1000000005');
  
  INSERT INTO OrderItems(order_num, 
                         order_item, 
                         prod_id, 
                         quantity, 
  						           item_price)
  VALUES (20010, 1, 'BR01', 10, 7.99);
  
  INSERT INTO OrderItems(order_num, 
  						           order_item, 
  						           prod_id, 
  						           quantity, 
  						           item_price)
  VALUES (20010, 2, 'BR03', 20, 11.99);
  
  COMMIT;
  
EXCEPTION
  WHEN myException THEN
  ROLLBACK TO start_transaction;

  RAISE;
  
END;

SELECT * FROM Orders;
SELECT * FROM OrderItems;

ROLLBACK;