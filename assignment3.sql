
CREATE DATABASE assignment_3;
USE assignment_3;

CREATE TABLE cart (
	id int PRIMARY KEY AUTO_INCREMENT,
	product varchar(40),
	quantity int
)

INSERT INTO cart (product, quantity)
VALUES 
	('Apple', 20),
	('Banana', 25),
	('Orange', 9);

-- DIRTY READ ----------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION

SELECT quantity
FROM cart 
WHERE product = 'Banana';

COMMIT;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION

UPDATE cart
SET quantity = 3
WHERE product = 'Banana';

ROLLBACK;
COMMIT;

-- NON-REPEATABLE READ ----------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION

SELECT sum(quantity) AS tolal_quantity
FROM cart;

SELECT sum(quantity) AS tolal_quantity
FROM cart;

COMMIT;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION

INSERT INTO cart (product, quantity)
VALUES 
	('Strawberry', 40);

COMMIT;

-- ------------------------------------------------------------------
DELETE FROM cart
WHERE product = 'Strawberry';
-- ------------------------------------------------------------------
-- REPEATABLE READ --------------------------------------------------
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION

SELECT sum(quantity) AS tolal_quantity
FROM cart;

SELECT sum(quantity) AS tolal_quantity
FROM cart;

COMMIT;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION

INSERT INTO cart (product, quantity)
VALUES 
	('Strawberry', 40);

COMMIT;
-- DEAD LOCK ---------------------------------------------------------
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION

UPDATE cart
SET quantity = 3
WHERE product = 'Apple';

UPDATE cart
SET quantity = 70
WHERE product = 'Banana';

COMMIT;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION

UPDATE cart
SET quantity = 100
WHERE product = 'Banana';

UPDATE cart
SET quantity = 13
WHERE product = 'Apple';

COMMIT;




