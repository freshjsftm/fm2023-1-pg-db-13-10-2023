DROP MATERIALIZED VIEW IF EXISTS "email_sezon_mt";
CREATE MATERIALIZED VIEW "email_sezon_mt" AS (
  SELECT "email", "birthday",(
  CASE extract('month' from "birthday")
    WHEN 1 THEN 'winter'
    WHEN 2 THEN 'winter'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    WHEN 8 THEN 'summer'
    WHEN 9 THEN 'fall'
    WHEN 10 THEN 'fall'
    WHEN 11 THEN 'fall'
    WHEN 12 THEN 'winter'
  END  
  ) AS "sezon"
  FROM "users"
);

SELECT * FROM "email_sezon";
SELECT * FROM "email_sezon_mt";


SELECT "email" 
FROM "email_sezon"
WHERE "sezon"='fall';

SELECT "sezon" , count(*)
FROM "email_sezon"
GROUP BY "sezon";

-- створіть вьюшку, яка зберігає айді та пошту користувача і кількість його замовлень

CREATE OR REPLACE VIEW "email_count_order" AS (
  SELECT u.id, u.email, count(o.*)
  FROM users AS u
    JOIN orders AS o ON u.id=o."userId"
  GROUP BY u.id
);


SELECT es.sezon, sum(eco.count) AS total
  FROM email_sezon AS es
    JOIN email_count_order AS eco ON es.email=eco.email
GROUP BY es.sezon
ORDER BY total DESC
LIMIT 1;


-- створити вьюшку з полями id та email користувача і загальна сума грошей яку він витратив
-- замовлення і його загальна вартість

DROP VIEW "users_spending";
CREATE VIEW "users_spending" AS (
  SELECT o."userId", u."email", sum(p."price"*pto."quantity") AS summa
  FROM "users" AS u
  JOIN "orders" AS o ON u."id"=o."userId"
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
  JOIN "phones" AS p ON pto."phoneId"=p."id"
  GROUP BY o."userId", u."email"
);


SELECT es.sezon, sum(us.summa) AS total
  FROM email_sezon AS es
    JOIN "users_spending" AS us ON es.email=us.email
GROUP BY es.sezon
ORDER BY total DESC;



-- gender(male/female) і  загальна сума витрачених коштів по групах

CREATE VIEW "email_gender" AS (
  SELECT "email",
    (
      CASE
        WHEN "isMale" THEN 'male'
        ELSE 'female'
      END
    ) AS "gender"
  FROM "users"
);

SELECT eg.gender, sum(us.summa) as total
FROM "email_gender" AS eg
  JOIN users_spending AS us ON eg.email=us.email
GROUP BY eg.gender 
ORDER BY total DESC ;



SELECT *
FROM phones
WHERE description IS NOT NULL;