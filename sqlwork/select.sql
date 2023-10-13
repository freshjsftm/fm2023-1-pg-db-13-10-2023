
SELECT *
FROM "users"
LIMIT 5 OFFSET 5;

SELECT "email", "isMale"
FROM "users";

SELECT *
FROM "users"
WHERE "isMale"=FALSE;

SELECT "email",  "isMale"
FROM "users"
WHERE "id"%2=0 
  AND "isMale"=TRUE
LIMIT 5 OFFSET 2;

SELECT *
FROM "users"
WHERE "firstName" = 'Jim';

SELECT *
FROM "users"
WHERE "firstName" IN ('Lisa','Marcus','Jim');

SELECT * 
FROM "users" 
WHERE "isMale"=TRUE AND "height">1.90;


SELECT * 
FROM "users" 
WHERE "isMale"=FALSE 
AND "height"<=1.85 AND "height">=1.65;


SELECT "id", "email", "birthday" 
FROM "users"
WHERE extract('year' from "birthday") = 1988;


SELECT "id", "email", "birthday" , 
age( "birthday"),
extract('years' from  age( "birthday"))
FROM "users"
WHERE extract('years' from  age( "birthday")) < 30;

SELECT "id", "email", "birthday" , 
age( "birthday"),
extract('years' from  age( "birthday"))
FROM "users"
WHERE age( "birthday") < make_interval(30);

--знайти усіх юзерів які народилися у жовтні
SELECT "id", "email", "birthday" , 
extract('month' from  "birthday")
FROM "users"
WHERE extract('month' from  "birthday") = 10;

--знайти усіх жінок молодше 45 років зростом більше 1.70
SELECT "id", "email", "birthday" , "isMale", "height",
extract('years' from  age("birthday")) AS "years"
FROM "users"
WHERE extract('years' from  age("birthday")) < 45
AND "isMale"=FALSE
AND "height" > 1.7;

--знайти усіх юзерів які народилися у 1 числа будь якого місяця будь якого року
SELECT "id", "email", "birthday" , 
extract('day' from  "birthday")
FROM "users"
WHERE extract('day' from  "birthday") = 1;

--знайти пошту усіх чоловіків старше 35 років зі зростом більше 1.85
SELECT "email"
FROM "users"
WHERE extract('years' from  age("birthday")) >35
AND "isMale"=TRUE
AND "height" > 1.85;




SELECT "id",
"firstName" || ' ' || "lastName" AS "full name"
FROM "users";

SELECT "id",
concat("firstName" , ' ' , "lastName") AS "full name"
FROM "users"
WHERE length(concat("firstName" , ' ' , "lastName")) <= 10;

--dont work
SELECT "id", concat("firstName" , ' ' , "lastName") AS "full name"
FROM "users"
WHERE length("full name") <= 10;

SELECT * --6
FROM
(
  SELECT "id", "isMale", concat("firstName" , ' ' , "lastName") AS "full name" --3
  FROM "users"  --1
  WHERE "isMale"=FALSE  --2
) AS "fnTable"  --4
WHERE length("fnTable"."full name")<=10; 
--5



--поверніть перші 10 телефонів з брендом Моторола або Соні
SELECT *
FROM "phones"
WHERE "brand" IN ('Motorola', 'Sony')
LIMIT 10;

--поверніть усі Xiaomi кількість яких менше 1000
SELECT *
FROM "phones"
WHERE "brand" = 'Xiaomi'
AND "quantity" < 1000;
--поверніть телефони, ціна яких більше 28 тисяч
SELECT *
FROM "phones"
WHERE "price" > 28000;
