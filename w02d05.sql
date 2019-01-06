--Q1. List all product names:
SELECT prod_name 
FROM products;

-- Q2. List all product names and their corresponding prices:
SELECT prod_name, prod_price
FROM products;

--Q3. List all columns from products table:
SELECT * 
FROM products;

--Q4. List all vendors with vendor id who we have the products:
SELECT vend_id 
FROM products;

--Q5. List the previous question without duplication:
SELECT DISTINCT vend_id 
FROM products;

--Q6. List any five product names:
SELECT prod_name 
FROM products
WHERE ROWNUM <= 5;

-- This is a single-line comment.

/* 
This is a block of comments 
for multiple lines. 
*/ 