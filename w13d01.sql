-----------------------------------------------------------------
/*
w13d01.sql
Dustin Meckley
ciss430 Database Systems
04/14/2016
*/ 
-----------------------------------------------------------------
-- Indexes:
-- Primary keys are always already indexed. 
-----------------------------------------------------------------
-- Q01: Create an index that includes cust_name and cust_zip
-- the two columns use frequently to find an customer.
-----------------------------------------------------------------
CREATE INDEX idx_customer
ON Customers (cust_name, cust_zip);

-----------------------------------------------------------------
-- Q02: We often search customers by state:
-----------------------------------------------------------------
CREATE INDEX idx_cust_state
ON Customers (cust_state);

-----------------------------------------------------------------
-- Stored Procedures:
-- A group of state functions. 
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Q03: An inserted stored procedure:
-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prc_order_add
(
	order_num_param NUMBER, 
	order_date_param DATE,
	cust_id_param CHAR
)
AS 
BEGIN
	INSERT INTO Orders(order_num, order_date, cust_id)
	VALUES(order_num_param, order_date_param, cust_id_param);
END;

SELECT * FROM Orders;
EXEC prc_order_add(21001, '12-Feb-16', '1000000001');
SELECT * FROM Orders;

-----------------------------------------------------------------
-- Q04: Update an stored procedure:
-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prc_update_orderItems_quantity
(
	order_num_param VARCHAR2,
	order_item_param NUMBER,
	quantity_return_param NUMBER
)
AS
BEGIN
	UPDATE OrderItems 
	SET quantity = quantity - quantity_return_param
	WHERE order_num = order_num_param 
	AND order_item = order_item_param;
END; 
    
-----------------------------------------------------------------
-- Q05: Delete an stored procedure:
-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE prc_customers_delete
(
	cust_id_param CHAR
)
AS
BEGIN
	IF cust_id_param IS NOT NULL THEN
		DELETE FROM Customers 
		WHERE cust_id = cust_id_param;
	END IF;
END; 

SHOW ERROR PROCEDURE prc_customers_delete;

-----------------------------------------------------------------
-- Triggers:
-- When an particular SQL statement such as: INSERT, UPDATE,
-- DELETE, CREATE, ALTER, DROP, etc. is executed as an block of 
-- P:/SQL codes are automatically fired. 
-----------------------------------------------------------------
-----------------------------------------------------------------
-- Q06: Revised Orders table by adding a new column called 
-- order_total which is the dollar amount of an order since we 
-- cannot change its existing values.  Make all existing orders
-- with $1000.00.
-----------------------------------------------------------------
ALTER TABLE Orders
ADD (order_total NUMBER(8, 2));

UPDATE Orders
SET order_total = 1000;

-----------------------------------------------------------------
-- Q07: Add an trigger that will automatically update the 
-- order_total column when an order is inserted.
-----------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_updateOrders
AFTER INSERT ON OrderItems
FOR EACH ROW
BEGIN
	UPDATE Orders
	SET order_total = order_total + 
					(:NEW.quantity) * (:NEW.item_price)
	WHERE order_num = :NEW.order_num;
END;

-----------------------------------------------------------------
-- Q08: Use the Trigger Created in Q07:
-----------------------------------------------------------------
SELECT * FROM Orders;

INSERT INTO OrderItems
VALUES (20009, 4, 'BR01', 100, 5.49);

-----------------------------------------------------------------
-- Q09: When a record within the OrderItems tables is deleted,
-- then the corresponding order_total should be updated.
-----------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_updateOrders_delete
AFTER DELETE ON OrderItems
FOR EACH ROW
BEGIN
	UPDATE Orders
	SET order_total = order_total - 
					((:OLD.quantity) * (:OLD.item_price))
	WHERE order_num = :OLD.order_num;
END;

/
DELETE FROM OrderItems 
WHERE order_num = 20009 AND order_item = 4;

-----------------------------------------------------------------
-- Q10: Set the quantity of an order item to 0 and if it is 
-- negative or more than 1000:
-----------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_quantity_within_range
BEFORE INSERT OR UPDATE ON OrderItems
FOR EACH ROW
WHEN (NEW.quantity < 0 OR NEW.quantity > 1000)
	BEGIN
		:NEW.quantity := 0;
	END;

UPDATE OrderItems
SET quantity = 10000
WHERE order_num = 20009 AND order_item = 1;

SELECT * FROM OrderItems;

INSERT INTO OrderItems
VALUES(20009, 5, 'BR02', -100, 2.99);
