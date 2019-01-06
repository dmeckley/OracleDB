-- Sorting Data:

-- Q01: List all products and their products prices.  
-- Sort the prices for low to high.
-- DESC for descending order.
SELECT prod_name, prod_price
FROM products
ORDER BY prod_price DESC;

-- Q02: List all products and their prices with the price of 3.49.
SELECT prod_name, prod_price
FROM products
WHERE prod_price = 3.49;

-- Q03: List all products and their prices less than 9.00.  
-- Sort them by price from high to low.
-- You can't switch ORDER BY and WHERE sequencially.
SELECT prod_name, prod_price
FROM products
WHERE prod_price < 9.00
ORDER BY prod_price DESC;
-- Can we skip the prod_price? Yes.
SELECT prod_name
FROM products
WHERE prod_price < 9.00
ORDER BY prod_price DESC;

-- Q04: List all product names and their prices with the price 
-- between 5 and 9 dollars.
-- [5, 9) most programming languages.
-- [5, 9] most SQL database preogramming.
SELECT prod_name, prod_price
FROM products
WHERE prod_price >= 5.00 AND prod_price <= 9.00;
-- OR:
--WHERE prod_price BETWEEN 5.00 AND 9.00;

-- Q05: Find customers who don't provide email address.  
-- List their names.
SELECT cust_name
FROM customers
WHERE cust_email IS NULL;

-- Q06: List all order quantities of BR01.
SELECT quantity
FROM orderItems
WHERE prod_id = 'BR01';