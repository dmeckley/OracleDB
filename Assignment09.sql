-----------------------------------------------------------------
/*
Assignment09.sql
Dustin Meckley
ciss430 Database Systems
04/07/2016
*/ 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Q01: Create a sequence named seq_order_num, start at 20010,
-- increment by 1.
-----------------------------------------------------------------
CREATE SEQUENCE seq_order_num
START WITH 20010
INCREMENT BY 1
MINVALUE 20010 MAXVALUE 1000000
CYCLE
CACHE 100
ORDER;

-----------------------------------------------------------------
-- Q02: Customer 1000000003 placed an order on June 1, 2012 with
-- the following products: 250 units of BR01 at $4.99 each and 
-- 5 units of BR02 at $9.99 each.  Insert the transaction into 
-- appropriate table(s) by using the sequence created in Q01.
-- Make the records final/permanent if no exceptions.
-----------------------------------------------------------------
DECLARE
  Exception_2 EXCEPTION;

BEGIN 
  SAVEPOINT start_transaction_2;

  INSERT INTO Orders(order_num,
                     order_date,
                     cust_id) 
  VALUES(seq_order_num.NEXTVAL, '1-Jun-12', '1000000003');
  
  INSERT INTO OrderItems(order_num, 
                         order_item, 
                         prod_id, 
                         quantity, 
  						           item_price)
  VALUES (seq_order_num.CURRVAL, 1, 'BR01', 250, 4.99);
  
  INSERT INTO OrderItems(order_num, 
  						           order_item, 
  						           prod_id, 
  						           quantity, 
  						           item_price)
  VALUES (seq_order_num.CURRVAL, 2, 'BR02', 5, 9.99);  

  COMMIT;
  
EXCEPTION
  WHEN Exception_2 THEN
  ROLLBACK TO start_transaction_2;

  RAISE;

END;

-----------------------------------------------------------------
-- Q03: A new vendor Mid-West Model Inc (1001 Rogers Street,
-- Columbia MO 65216) supplies two new products to Cougar Toys:

-- 20 feet wooden train (20 feet total track length best for kids
-- ages 7-12) price $19.99.  Use product id of "wt01"

-- 30 feet wooden train (30 feet total track length best for kids
-- ages 8-15) price $27.99. Use product id of "wt02"

-- Write SQL codes to insert the data and make it final/permanent
-- if no exceptions.

-- Use vendor id of "MWM01"
-----------------------------------------------------------------
DECLARE
  Exception_3 EXCEPTION;

BEGIN 
  SAVEPOINT start_transaction_3;

  INSERT INTO Vendors(vend_id, 
                      vend_name, 
                      vend_address, 
                      vend_city,
                      vend_state,
                      vend_zip,
                      vend_country)
  VALUES ('MWM01', 
          'Mid-West Model Inc', 
          '1001 Rogers Street',
          'Columbia',
          'MO',
          '65213',
          'USA');

  INSERT INTO Products(prod_id, 
                       vend_id, 
                       prod_name,
                       prod_price,
                       prod_desc)
  VALUES ('wt01', 
          'MWM01',
          '20 feet wooden train',
          19.99,
          '30 feet total track length best for kids ages 8-15');

  INSERT INTO Products(prod_id, 
                       vend_id, 
                       prod_name,
                       prod_price,
                       prod_desc)
  VALUES ('wt02', 
          'MWM01',
          '30 feet wooden train',
          27.99,
          '30 feet total track length best for kids ages 8-15'); 

COMMIT;
  
EXCEPTION
  WHEN Exception_3 THEN
  ROLLBACK TO start_transaction_3;

  RAISE;
  
END;

-----------------------------------------------------------------
-- Q04: You received a phone call from customer 1000000003 to 
-- report the errors in order she placed on Jan. 12, 2012.

-- The records shows 10 units of BR02 with the item price of 
-- $8.99.

-- She actually ordered 500 units of BR02 and she also wants a 
-- better price due to the large quantity.

-- Your manager confirmed that she was right and agreed to offer
-- the new price at $7.99.

-- Your manager asked you to modify the records accordingly.

-- Write SQL statement to accomplish this task.  (You cannot find
-- out order_num manually and use that number in SQL)

-- Use only the data provided in the question.  Also, understand 
-- the fact that OrderItems table may contain thousands of 
-- records
-----------------------------------------------------------------
UPDATE OrderItems
SET quantity = 500, item_price = 7.99
WHERE prod_id = 'BR02' 
AND order_num = (SELECT order_num
  				       FROM Orders
  				       WHERE order_date = '12-JAN-12'
  				       AND cust_id = (SELECT cust_id
  				 				              FROM Customers
  				 				              WHERE cust_id = '1000000003'));

-----------------------------------------------------------------
-- Q05: April is national discount month, Cougar Toy LLC will
-- give 10% discount to all customers for each OrderItem in an 
-- Order that is 100 units or more (cannot have item quantity
-- combined).

-- This discount applies to all orders (no matter when they are 
-- placed).

-- Write SQL code to accomplish this.

-- For example, Order_num 20010 contains 250 units of BR01 with 
-- price $4.99 should now be $4.49.

-- Another example, Order_num 20010 contains 5 units of BR02 with
-- price $9.99 won't be affected.
-----------------------------------------------------------------
UPDATE OrderItems
SET item_price = item_price - (item_price * .10)
WHERE quantity >= 100;

-----------------------------------------------------------------
-- Q06: Write SQL statements to bring back all data as it is 
-- before you started this homework.  Pay attention to the 
-- sequence of your statements (This time you are allowed to 
-- manually find out numbers in the table and use it in the code)
-- Make it final/permanent.
-----------------------------------------------------------------
-- Q05: Back To Original:
UPDATE OrderItems
SET item_price = item_price / .90
WHERE quantity >= 100;

-- Q04: Back To Original:
UPDATE OrderItems
SET quantity = 10, item_price = 8.99
WHERE prod_id = 'BR02' 
AND order_num = (SELECT order_num
                 FROM Orders
                 WHERE order_date = '12-JAN-12'
                 AND cust_id = (SELECT cust_id
                                FROM Customers
                                WHERE cust_id = '1000000003'));

-- Q03: Back To Original:
DELETE 
FROM Products 
WHERE vend_id = 'MWM01';

DELETE 
FROM Vendors 
WHERE vend_id = 'MWM01';

-- Q02: Back To Original:
DELETE 
FROM OrderItems 
WHERE order_num = '20010';

DELETE 
FROM Orders 
WHERE order_num = '20010';

-- Q01: Back To Original:
DROP SEQUENCE seq_order_num;