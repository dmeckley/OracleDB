-----------------------------------------------------------------
/*
w11d03.sql
Dustin Meckley
ciss430 Database Systems
03/23/2016
*/ 
-----------------------------------------------------------------
-- COMMIT and ROLLBACK work only with DML.
-- Can't ROLLBACK something that has already been COMMITed.

-- SEQUENCE is an object that will generate integer numbers 
-- automatically.  They promise all numbers will not be 
-- duplicated but they don't promise the order of the sequence.
-----------------------------------------------------------------
-- Q01: Creation of a SEQUENCE object. 
-----------------------------------------------------------------
CREATE SEQUENCE order_seq;

-----------------------------------------------------------------
-- Q02: Creation of another SEQUENCE object. 
-----------------------------------------------------------------
CREATE SEQUENCE order_seq1
START WITH 20010
INCREMENT BY 2
MINVALUE 20010 MAXVALUE 1000000
CYCLE
CACHE 100
ORDER;

-----------------------------------------------------------------
-- Q03: Use NEXTVAL.
-----------------------------------------------------------------
SELECT order_seq1.NEXTVAL
FROM dual;

-----------------------------------------------------------------
-- Q04: INSERT INTO the Orders table a specific Value.
-----------------------------------------------------------------
INSERT INTO Orders 
VALUES(order_seq1.NEXTVAL, SYSDATE, 1000000001);

SELECT * 
FROM Orders;

-----------------------------------------------------------------
-- Q05: Use CURRVAL.
-----------------------------------------------------------------
SELECT order_seq1.NEXTVAL 
FROM dual;

SELECT order_seq1.CURRVAL 
FROM dual;

-----------------------------------------------------------------
-- Q06: Can be changed like any other object.
-----------------------------------------------------------------
ALTER SEQUENCE order_seq1
INCREMENT BY 1;

SELECT order_seq1.NEXTVAL 
FROM dual;

