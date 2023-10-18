-- отримати усі замовлення і пошту конкретного юзера 7

SELECT "users"."id", "users"."email", "orders"."id"
FROM "users"
  INNER JOIN "orders" ON "users"."id"="orders"."userId"
WHERE "users"."id"=9;

SELECT u."id", u."email", o."id"
FROM "users" AS u
  INNER JOIN "orders" AS o ON u."id"=o."userId"
WHERE u."id"=9;

SELECT u."email", o."id"
FROM "users" AS u
  INNER JOIN "orders" AS o ON u."id"=o."userId"
WHERE u."id"=9;

-- отримати айді замовлень, в яких купували Sony
SELECT o."id" , p."brand", p."model"
FROM "orders" AS o
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
  JOIN "phones" AS p ON pto."phoneId"=p."id"
WHERE p."brand" ILIKE 'sony' AND o."id"=2; 

-- отримати айді замовлень, в яких купували Sony і порахувати кількість моделей по кожному замаовленню
SELECT o."id" , p."brand", count(p."model"), u."email"
FROM "users" AS u
  JOIN "orders" AS o ON u."id"=o."userId"
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
  JOIN "phones" AS p ON pto."phoneId"=p."id"
WHERE p."brand" ILIKE 'sony' 
GROUP BY  o."id", p."brand", u."email"
HAVING count(p."model")>=3
ORDER BY  o."id";

-- кількість проданих телефонів по моделях
SELECT p."model", sum(pto."quantity")
FROM "phones_to_orders" AS pto
  JOIN "phones" AS p ON pto."phoneId"=p."id"
GROUP BY  p."model";

INSERT INTO phones (
    brand,
    model,
    price,
    quantity
  )
VALUES (
    'DDD',
    'qwerty 1',
    12456,
    5
  );

-- телефони, які НЕ купували

SELECT p."model", p."brand"
FROM "phones" AS p
  LEFT JOIN "phones_to_orders" AS pto ON p."id"=pto."phoneId"
WHERE pto."phoneId" IS NULL
GROUP BY p."model", p."brand";

SELECT p."model", p."brand"
FROM "phones_to_orders" AS pto
  RIGHT JOIN "phones" AS p ON pto."phoneId"=p."id"
WHERE pto."phoneId" IS NULL  
GROUP BY   p."model", p."brand";



-- обрати пошту користувачів, які купляли Iphone
SELECT DISTINCT u."email", p."brand" 
FROM "users" AS u
  JOIN "orders" AS o ON u."id"=o."userId"
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
  JOIN "phones" AS p ON pto."phoneId"=p."id"
WHERE p."brand"='Iphone'
ORDER BY u."email";


-- обрати пошту користувачів, у яких кількість замовлень більше 3
SELECT u."email", count(o.*)
FROM "users" AS u 
 JOIN "orders" AS o ON u."id" = o."userId"
 GROUP BY u."email"
 HAVING count(o.*)>3
 ORDER BY u."email";

-- обрати пошту користувачів, які купляли телефон з id=33
SELECT DISTINCT u."email" 
FROM "users" AS u
  JOIN "orders" AS o ON u."id"=o."userId"
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
WHERE pto."phoneId"=33;


-- вивести найпопулярніший телефон
SELECT p."model", p."brand", sum(pto."quantity") AS "amount"
FROM phones AS p 
 JOIN phones_to_orders AS pto ON p."id"=pto."phoneId"
GROUP BY p."model" , p."brand"
ORDER BY "amount" DESC
LIMIT 1;

