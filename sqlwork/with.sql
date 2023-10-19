-- дістати користувача (email) і кількість моделей, які він купив
-- отримуємо користувача і усі телефони
SELECT u."id",
  u."email",
  p."id"
FROM "users" AS u
  JOIN "orders" AS o ON u."id" = o."userId"
  JOIN "phones_to_orders" AS pto ON o."id" = pto."orderId"
  JOIN "phones" AS p ON pto."phoneId" = p."id"
GROUP BY u."id",
  p."id"
ORDER BY u."id";
SELECT uwp.uid,
  uwp.email,
  count(uwp.pid)
FROM (
    SELECT u."id" AS uid,
      u."email" AS email,
      p."id" AS pid
    FROM "users" AS u
      JOIN "orders" AS o ON u."id" = o."userId"
      JOIN "phones_to_orders" AS pto ON o."id" = pto."orderId"
      JOIN "phones" AS p ON pto."phoneId" = p."id"
    GROUP BY u."id",
      p."id"
    ORDER BY u."id"
  ) AS uwp
GROUP BY uwp.uid,
  uwp.email;
WITH uwp AS (
  SELECT u."id" AS uid,
    u."email" AS email,
    p."id" AS pid
  FROM "users" AS u
    JOIN "orders" AS o ON u."id" = o."userId"
    JOIN "phones_to_orders" AS pto ON o."id" = pto."orderId"
    JOIN "phones" AS p ON pto."phoneId" = p."id"
  GROUP BY u."id",
    p."id"
  ORDER BY u."id"
)
SELECT uwp.uid,
  uwp.email,
  count(uwp.pid)
FROM uwp
GROUP BY uwp.uid,
  uwp.email;
-- вивести усі замовлення, загальний чек який більше середнього чеку
-- рахуємо чек замовлення
SELECT pto."orderId", sum(pto."quantity" * p."price")
FROM "phones_to_orders" AS pto
  JOIN "phones" AS p ON pto."phoneId" = p."id"
GROUP BY pto."orderId";

--рахуємо середній чек
SELECT avg(ochek.chek)
FROM (
  SELECT pto."orderId", sum(pto."quantity" * p."price") AS chek
    FROM "phones_to_orders" AS pto
      JOIN "phones" AS p ON pto."phoneId" = p."id"
    GROUP BY pto."orderId"
) AS ochek;


SELECT ochek.*
FROM (
  SELECT pto."orderId", sum(pto."quantity" * p."price") AS chek
    FROM "phones_to_orders" AS pto
      JOIN "phones" AS p ON pto."phoneId" = p."id"
    GROUP BY pto."orderId"
) AS ochek
WHERE ochek.chek > (
  SELECT avg(ochek.chek)
    FROM (
      SELECT pto."orderId", sum(pto."quantity" * p."price") AS chek
        FROM "phones_to_orders" AS pto
          JOIN "phones" AS p ON pto."phoneId" = p."id"
        GROUP BY pto."orderId"
    ) AS ochek
)



WITH ochek AS (
  SELECT pto."orderId", sum(pto."quantity" * p."price") AS chek
    FROM "phones_to_orders" AS pto
      JOIN "phones" AS p ON pto."phoneId" = p."id"
    GROUP BY pto."orderId"
) 
SELECT ochek.*
FROM ochek
WHERE ochek.chek > (SELECT avg(ochek.chek) FROM ochek);



--отримати користувачів, у яких кількість замовлень менше середньої

-- користувач і кількість
SELECT u."email", count(o.*) 
FROM "users" AS u
  LEFT JOIN "orders" AS o ON u."id"=o."userId"
GROUP BY u."id"  
-- середнє значення кількості
SELECT avg(uoa.amount)
FROM (
  SELECT u."email", count(o.*) AS amount
  FROM "users" AS u
    LEFT JOIN "orders" AS o ON u."id"=o."userId"
  GROUP BY u."id"
) AS uoa --user_order_amount

-- скласти до купи два попередні запити
SELECT uoa.*
FROM (
  SELECT u."email", count(o.*) AS amount
  FROM "users" AS u
    LEFT JOIN "orders" AS o ON u."id"=o."userId"
  GROUP BY u."id"
) AS uoa
WHERE uoa.amount < (
  SELECT avg(uoa.amount)
    FROM (
      SELECT u."email", count(o.*) AS amount
      FROM "users" AS u
        LEFT JOIN "orders" AS o ON u."id"=o."userId"
      GROUP BY u."id"
    ) AS uoa
)

-- оптимізувати
WITH uoa AS (
  SELECT u."email", count(o.*) AS amount
  FROM "users" AS u
    LEFT JOIN "orders" AS o ON u."id"=o."userId"
  GROUP BY u."id"
)
SELECT uoa.*
FROM uoa
WHERE uoa.amount < (SELECT avg(uoa.amount) FROM uoa)
ORDER BY uoa.amount;