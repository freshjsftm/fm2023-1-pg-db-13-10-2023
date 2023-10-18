
CREATE TABLE a(s VARCHAR(8), q INT);
CREATE TABLE b(w VARCHAR(8));

INSERT INTO a VALUES('qwe', 1), ('asd', 2), ('zxc', 3);
INSERT INTO b VALUES('qwe'), ('asd'), ('xxx'),('vvv');

SELECT * FROM a, b 
WHERE a.s=b.w;

SELECT *
FROM a 
  JOIN b ON a.s=b.w;

SELECT s FROM a
UNION
SELECT w FROM b;

SELECT s FROM a
INTERSECT
SELECT w FROM b;

SELECT s FROM a
EXCEPT
SELECT w FROM b;

SELECT w FROM b
EXCEPT
SELECT s FROM a;




-- дістати id користувачів, які робили замовлення
SELECT "id" FROM "users"
INTERSECT
SELECT "userId" FROM "orders";

-- дістати id користувачів, які НЕ робили замовлення
SELECT "id" FROM "users"
EXCEPT
SELECT "userId" FROM "orders";



