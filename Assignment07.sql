-----------------------------------------------------------------
/*
Assignemnt07.sql
Dustin Meckley
ciss430 Database Systems
03/14/2016
*/ 
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Q01: List all product names is in the orders. 
-----------------------------------------------------------------
SELECT prod_name
FROM Products 
WHERE prod_id IN (SELECT prod_id
			      FROM OrderItems
			      WHERE order_num IN (SELECT order_num
			      					  FROM Orders
			      					  WHERE OrderItems.order_num 
			      					  = Orders.order_num));

-----------------------------------------------------------------
-- Q02: List the names of the customers who ordered in Feb 2012
-- but not the last 10 days of Feb.
-----------------------------------------------------------------
SELECT cust_name
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders 
                  WHERE order_date < '18-FEB-12'
                  AND order_date >= '01-FEB-12');

-----------------------------------------------------------------
-- Q03: What is the most expensive product?  List the product 
-- name and its price.
-----------------------------------------------------------------
SELECT prod_name, prod_price AS Most_Expensive
FROM Products 
WHERE prod_price IN (SELECT MAX(prod_price) 
                     FROM Products);

-----------------------------------------------------------------
-- Q04: List all customer who purchased from the company.  List
-- the customer names and the dates they made a purchase.
-----------------------------------------------------------------
SELECT cust_name, order_date
FROM Customers JOIN Orders
ON Customers.cust_id = Orders.cust_id; 

-----------------------------------------------------------------
-- Q05: List customer name and the date they made a purchase, and
-- the product in the purchase for customer with cust_id = 
-- 1000000005.
-----------------------------------------------------------------
SELECT cust_name, order_date, prod_name
FROM Customers JOIN Orders
ON (Customers.cust_id = Orders.cust_id)
JOIN OrderItems
ON (Orders.order_num = OrderItems.order_num)
JOIN Products
ON (OrderItems.prod_id = Products.prod_id)
WHERE Customers.cust_id = '1000000005';

-----------------------------------------------------------------
-- Q06: List all customer names and the date of their last order/
-- most recent order.  If a customer never placed and order, add
-- NULL to that.
-----------------------------------------------------------------
SELECT cust_name, order_date AS Recent_Order
FROM Customers LEFT JOIN Orders
ON Customers.cust_id = Orders.cust_id
WHERE order_date IS NULL 
OR order_date = (SELECT MAX(order_date)
				 FROM Orders
				 WHERE Orders.cust_id = Customers.cust_id);

-----------------------------------------------------------------
-- Q07: Write Oracle SQL code to create all remaining tables of 
-- Cougar Toys.
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

CREATE TABLE payment_method
(
	method_num NUMBER(2) NOT NULL,
	method_name VARCHAR2(50 BYTE) NOT NULL,
	description VARCHAR2(500 BYTE) NOT NULL,
	
	CONSTRAINT payment_method_pk PRIMARY KEY (method_num)
);

CREATE TABLE payment
(
	payment_num NUMBER(10) NOT NULL,
	payment_date DATE DEFAULT SYSDATE,
	cust_id CHAR(10 BYTE) NOT NULL,
	payment_amount NUMBER(10,2) NOT NULL,
	method_num NUMBER(2) NOT NULL,

	CONSTRAINT payment_pk PRIMARY KEY (payment_num),
	CONSTRAINT payment_fk_customers FOREIGN KEY (cust_id)
    REFERENCES customers(cust_id) ON DELETE CASCADE,
	CONSTRAINT payment_fk_payment_method FOREIGN KEY (method_num)
    REFERENCES payment_method(method_num) ON DELETE CASCADE	
);

CREATE TABLE transaction
(
	transaction_num NUMBER(10) NOT NULL,
	invoice_num NUMBER(10) NOT NULL, 
	payment_num NUMBER(10) NOT NULL,
	transaction_amount NUMBER(10, 2) NOT NULL, 
	transaction_date DATE DEFAULT SYSDATE,

	CONSTRAINT transaction_pk PRIMARY KEY (transaction_num),
	CONSTRAINT transaction_fk_invoice FOREIGN KEY (invoice_num)
    REFERENCES invoice(invoice_num) ON DELETE CASCADE,
	CONSTRAINT transaction_fk_payment FOREIGN KEY (payment_num)
    REFERENCES payment(payment_num) ON DELETE CASCADE	
);

CREATE TABLE payment_bank
(
	cust_id CHAR(10 BYTE) NOT NULL,
	bank_routing NUMBER(9) NOT NULL,
	account_num NUMBER(12) NOT NULL,
	description VARCHAR2(100 BYTE) NOT NULL,
	

	CONSTRAINT payment_bank_pk 
	PRIMARY KEY (cust_id, bank_routing, account_num),
	CONSTRAINT payment_bank_fk_customers FOREIGN KEY (cust_id)
    REFERENCES customers(cust_id) ON DELETE CASCADE
);

CREATE TABLE payment_card
(
	cust_id CHAR(10 BYTE) NOT NULL,
	card_num NUMBER(16) NOT NULL,
	exp_date DATE DEFAULT SYSDATE,
	sec_code NUMBER(6) NOT NULL,
	
	CONSTRAINT payment_card_pk PRIMARY KEY (cust_id, card_num),
	CONSTRAINT payment_card_fk_customers FOREIGN KEY (cust_id)
    REFERENCES customers(cust_id) ON DELETE CASCADE
);

-----------------------------------------------------------------
-- Q08: Write Oracle SQL code to remove tables that you created
-- in Q07.
-----------------------------------------------------------------
DROP TABLE payment_card;
DROP TABLE payment_bank;
DROP TABLE transaction;
DROP TABLE payment;
DROP TABLE payment_method;
DROP TABLE invoice;






