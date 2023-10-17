-- sort

SELECT "id", "height", "firstName"
FROM "users"
ORDER BY "height", "firstName";

SELECT "id", "height", "firstName"
FROM "users"
ORDER BY "height" DESC
LIMIT 1;


SELECT "id", "height", "firstName"
FROM "users"
ORDER BY "height" DESC, "firstName" ASC;


-- відсортувати за роком народження від старших до молодших, а потім за зростом від великих до маленьких
SELECT "id", extract(years from "birthday") AS "yearbd", "height"
FROM "users"
ORDER BY "yearbd" ASC, "height" DESC;

-- повернути ім'я і вік 10 наймолодших людей від меншого до більшого, імена в алфавітному порядку
SELECT "id", extract(years from age("birthday")) AS "age", "firstName"
FROM "users"
ORDER BY "age" ASC, "firstName" ASC;


-- порахувати кількість людей по роках народження і вивести данні від старших до молодших
-- виводити ті, де кількість від 3 включно
SELECT * FROM (
    SELECT count(*) AS "count", extract("years" from "birthday") AS "year"
      FROM "users"
      GROUP BY "year"
  ) AS "CY"
GROUP BY "CY"."count", "CY"."year"
HAVING "CY"."count" >= 3
ORDER BY "CY"."year";

-- порахувати кількість моделей кожного бренда телефона і вивести від найбільшої кількості до найменшої
-- виводити тільки ті данні де кількість менше 5
SELECT count(*) AS "count", "brand" --4
FROM "phones"  --1
WHERE "brand" IN ('Sony', 'Honor') --2
GROUP BY "brand"  --3.1
HAVING count(*) <= 5 --3.2
ORDER BY "count" DESC; --5

-- дістати назви брендів, у яких кількість телефонів на складі більше 10000  вивести бренд за алфавітом і кількість

SELECT "brand", sum("quantity") AS "total q"
FROM "phones"
GROUP BY "brand"
HAVING sum("quantity") > 9000
ORDER BY "brand";



SELECT count(*), "userId"
FROM "orders"
GROUP BY "userId"
HAVING count(*)>=5
ORDER BY "userId";