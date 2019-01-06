-----------------------------------------------------------------
/*
w12d01.sql
Dustin Meckley
ciss430 Database Systems
04/04/2016
*/ 
-----------------------------------------------------------------
--                       Tables:
-----------------------------------------------------------------
-- ALTER Table and View to change structure or dictionary of the
-- address.
-----------------------------------------------------------------
-- Q01: Add a column to the Customers table which shows who 
-- entered a new customer.
-----------------------------------------------------------------
ALTER TABLE Customers
ADD (entered_by NUMBER(3));

-----------------------------------------------------------------
-- Q02: Add a constraint to make sure each order item is 10 or 
-- more of quantity.
-----------------------------------------------------------------
ALTER TABLE OrderItems
ADD CONSTRAINT min_order_check CHECK (quantity >= 5);

INSERT INTO OrderItems(order_num, 
					   order_item, 
					   prod_id, 
					   quantity, 
					   item_price)
VALUES (20009, 11, 'BR01', 14, 11.11);

DELETE FROM OrderItems WHERE order_item = 11; 

-----------------------------------------------------------------
-- Q03: Same as Q01.  Make the default value to 001.
-----------------------------------------------------------------
ALTER TABLE Customers
MODIFY (entered_by DEFAULT 001);

INSERT INTO Customers(cust_id, 
					   cust_name, 
					   cust_address, 
					   cust_city, 
					   cust_state, 
					   cust_zip, 
					   cust_country,
					   cust_contact, 
					   cust_email)
VALUES ('1000000006', 
	    'Cougar Kindergarden',
	    '1001 Rogers Street',
	    'Columbia',
	    'MO',
		'65216',
		'USA',
		'Dustin Meckley',
		'djmeckley1@cougars.ccis.edu');

-----------------------------------------------------------------
-- Q04: Change the data type for zip form Varchar2 to Number(5). 
-----------------------------------------------------------------
ALTER TABLE Customers
MODIFY cust_zip CHAR(5);
