-- WHERE clause

-- Q01: List process id, product price, and product name 
-- from vendor DDL01 and price lass than 4:
SELECT prod_id, prod_price, prod_name
FROM products
WHERE vend_id = 'DLL01' AND prod_price < 4;

-- Q02: List all product names and their prices from vendor
-- DLL01 and BRS01:
SELECT prod_name, prod_price
FROM products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';

-- Q03: List all product names and their prices from vendor
-- DLL01 and BRS01.  Then show that the price is only over
-- $10:
SELECT prod_name, prod_price
FROM products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01') 
AND prod_price >= 10;

-- Q04: Using the IN operator:
SELECT prod_name, prod_price
FROM products
WHERE vend_id IN ('DLL01', 'BRS01') AND prod_price >= 10;

-- Q05: Using the NOT operator, list all product names and  
-- their prices from all vendors except DLL01:
SELECT prod_name, prod_price
FROM products
WHERE NOT vend_id = 'DLL01';
-- OR:
SELECT prod_name, prod_price
FROM products
WHERE vend_id <> 'DLL01';
-- OR:
SELECT prod_name, prod_price
FROM products
WHERE vend_id != 'DLL01';

-- Q06: Using the LIKE operator, list prod_id and product name 
-- for all product names that start with Fish:
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE 'Fish%';

-- Q07: List product id and name for all product names that 
-- contain words "bean bag":
SELECT prod_id, prod_name
FROM products
WHERE prod_name LIKE '%bean bag%';

-- Q08: List all vendor names that are from a state starting 
-- with M:
SELECT svend_name
FROM vendors
WHERE vend_state LIKE 'M';