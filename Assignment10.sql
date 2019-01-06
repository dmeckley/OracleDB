-----------------------------------------------------------------
/*
Assignment10.sql
Dustin Meckley
ciss430 Database Systems
04/14/2016
*/ 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Q01: Enter a new column in the OrderItems table to show who 
-- packed the OrderItem.  Name the new column as packed_by, pick
-- an appropriate data type.
-----------------------------------------------------------------
ALTER TABLE OrderItems
ADD (packed_by VARCHAR(100 BYTE));

-----------------------------------------------------------------
-- Q02: cust_country column in Customers table is almost always 
-- "USA", make "USA" as default value for Customers, then insert
-- a new Customer using the default value.
----------------------------------------------------------------- 
ALTER TABLE Customers
MODIFY (cust_country DEFAULT 'USA');

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
        'Dustin Meckley Inc.',
        '23530 Audrain County Road 324',
        'Mexico',
        'MO',
        '65265',
        DEFAULT,
        'Dustin Meckley',
        'djmeckley1@cougars.ccis.edu');

-----------------------------------------------------------------
-- Q03: Write SQL code so that when an Order is cancelled, all 
-- related OrderItems are removed.
-----------------------------------------------------------------
ALTER TABLE OrderItems
DROP CONSTRAINT fk_OrderItems_Orders;

ALTER TABLE OrderItems
ADD CONSTRAINT OrderItems_fk_Orders FOREIGN KEY (order_num)
  REFERENCES Orders (order_num)
  ON DELETE CASCADE;

ALTER TABLE Orders
DROP CONSTRAINT fk_Orders_Customers;

ALTER TABLE Customers
ADD CONSTRAINT Orders_fk_Customers FOREIGN KEY (cust_id)
  REFERENCES Customers(cust_id)
  ON DELETE CASCADE;

DELETE FROM Orders
WHERE order_num = 20005;

-----------------------------------------------------------------
-- Q04: Remove vendor "BRS01" from the Vendors tables.  However, 
-- we want to keep all Products of "BRS01".
-- You are not allowed to remove the referential integrity.
-- Hint: Reset the vend_id from NOT NULL to NULL.  
-- ON DELETE SET NULL should be used.
-----------------------------------------------------------------
ALTER TABLE Products
MODIFY vend_id NULL;

ALTER TABLE Products
DROP CONSTRAINT fk_Products_Vendors;

ALTER TABLE Products
ADD CONSTRAINT fk_Products_Vendors FOREIGN KEY(vend_id)
	REFERENCES Vendors(vend_id)
	ON DELETE SET NULL;
  
DELETE FROM Vendors 
WHERE vend_id = 'BRS01';

-----------------------------------------------------------------
-- Q05: Customer state is always two characters and customer zip
-- is always 5 digits.  Change their data types to more 
-- appropriate ones.  Data in the table should not be lost. 
-----------------------------------------------------------------
ALTER TABLE Customers
MODIFY cust_state CHAR(2);

ALTER TABLE Customers
MODIFY cust_zip CHAR(5);

-----------------------------------------------------------------
-- Q06: Create an updatable view that includes vendor_id and 
-- vendor_name.
-- Name the view as viewVendors.
-- Next write codes to add a new vendor with vendor_id of "ABC01"
-- and vendor_name of your real name.  
-- Write code to check if the view is "updatable".
-----------------------------------------------------------------
CREATE VIEW viewVendors AS 
SELECT vend_id, vend_name
FROM Vendors;

INSERT INTO viewVendors(vend_id, vend_name)
VALUES('ABC01', 'Dustin J Meckley');

UPDATE viewVendors
SET vend_name = 'Dustin Meckley'
WHERE vend_id = 'ABC01';

SELECT * FROM Vendors;
SELECT * FROM viewVendors;

-----------------------------------------------------------------
-- Q07: Create a view called vipCustomers that list all customers
-- whose total order amount are the top three of all customers.
-- Include customer_name and the total in descending order.
-- Column head for customer name is "Customer" and total order is
-- "Total".
-- Now write codes to show everything in the view.
-- Make sure numbers are properly formatted.
-----------------------------------------------------------------
CREATE VIEW vipCustomers AS
SELECT C.cust_name AS Customer,
       TO_CHAR(SUM(OI.quantity * OI.item_price), '9999.99')
       AS "Total"
FROM Customers C JOIN Orders O
ON C.cust_id = O.cust_id
JOIN OrderItems OI 
ON O.order_num = OI.order_num
GROUP BY C.cust_name
ORDER BY SUM(OI.quantity * OI.item_price) DESC; 