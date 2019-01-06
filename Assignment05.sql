-----------------------------------------------------------------
/*
Assignment 5 Part 2: Assignment05.sql
Dustin Meckley
ciss430 Database Systems
02/19/2016
*/ 
-----------------------------------------------------------------
/*
Q01: Show all customer's city with their corresponding state
in parentheses Ex: Chicago (IL), same location should only
show up once:
*/
SELECT cust_city || ' (' || cust_state || ')'
FROM Customers;
-----------------------------------------------------------------
/*
Q02: Combine the following columns from customers table as
one column with the new column head as "Mailing Address"
customer name, address, city, state, zip, and country:
*/
SELECT cust_name || ' ' || cust_address || ' ' ||
       cust_city || ', ' || cust_state
       || ' ' || cust_zip || ' ' || cust_country 
       AS "Mailing Address"
FROM Customers;
-----------------------------------------------------------------
/*
Q03: List all product name, their price, and a new column 
called "New Price" which should be 10 percent increase based
on the current price.  Make sure your new price only show two
decimal places:
*/
SELECT prod_name, prod_price,  
       TO_CHAR(prod_price + (prod_price * .10), '9,999,999.99') 
       AS "New Price"
FROM Products;
-----------------------------------------------------------------
/*
Q04: List all orders from the order table, including all columns,
make the order_date in the format of 11/12/2014 if the date is 
November 12, 2014:
*/
SELECT order_num, 
       TO_CHAR(order_date, 'mm/dd/yyyy') 
       AS "ORDER_DATE", 
       cust_id
FROM Orders;
-----------------------------------------------------------------
/*
Q05: List all customer's street name first word, Ex: 200 Maple 
Lane will be Maple.  If a street name contains more than one 
word, just show the first word. (No Regular Expressions allowed 
for grading purposes):
*/
SELECT
CASE
  WHEN INSTR(cust_address, ' ') = 0
  THEN NULL
  WHEN INSTR(cust_address, ' ', 1, 2) = 0 
  THEN SUBSTR(cust_address, INSTR(cust_address, ' ') + 1)
  WHEN INSTR(cust_address, ' ', 1, 2) > 0 
  THEN SUBSTR(cust_address, INSTR(cust_address, ' ') + 1, 
  INSTR(cust_address, ' ', 1, 2) - INSTR(cust_address, ' ', 1, 1) 
  - 1) 
  END AS "First word of the street name"
  FROM Customers;
-----------------------------------------------------------------
/*
Q06: List everything in the Orderitems table, replace BR01 with 
its full product name (Replace BR01 with 8 Inch teddy bear):
*/
SELECT order_num, order_item, 
       REPLACE(prod_id, 'BR01', '8 Inch teddy bear') 
       AS "PROD_ID", 
       quantity, item_price
FROM Orderitems;



