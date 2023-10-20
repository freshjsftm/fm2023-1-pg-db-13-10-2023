-- CASE

/*
CASE
  WHEN cond1=true THEN act1
  WHEN cond2=true THEN act2
  ELSE act3
END
*/


/*
CASE key
  WHEN var1 THEN act1
  WHEN var2 THEN act2
  WHEN var3 THEN act3
  ELSE act4
END
*/

SELECT (
  CASE
    WHEN true=false THEN '+'
    WHEN true=false THEN '-'
    ELSE '?'
  END  
  ) AS test;

SELECT "firstName", (
  CASE
    WHEN "isMale" THEN 'male'
    ELSE 'female'
  END 
  ) as gender
FROM "users";



SELECT "email", "birthday",(
CASE extract('month' from "birthday") --1
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
FROM "users";

-- вивести три стовпчики: емейл, дата народження і статус, в якому буде pensioner, якщо людині 55 і більше, і worker в іншому випадку

SELECT "email", "birthday", (
  CASE
    WHEN extract('year' from age("birthday")) >= 55 THEN 'pensioner'
    ELSE 'worker'
  END 
  ) as status
FROM "users";


SELECT "model",
  "brand",
  (
    CASE
      WHEN "brand" ILIKE 'iphone' THEN 'Apple'
      ELSE 'other'
    END
  ) AS manufacture
FROM "phones"; 

SELECT "model",
  "brand",
  (
    CASE "brand"
      WHEN 'iphone' THEN 'Apple'
      WHEN 'Iphone' THEN 'Apple'
      ELSE 'other'
    END
  ) AS manufacture
FROM "phones";



-- вивести модель ціна і статус, в якому буде значення  above/below залежно від того чи більша ціна за середню ціну 


SELECT "model",
  "price",
  (
    CASE
      WHEN "price" > (SELECT avg("price") FROM "phones") THEN 'above'
      ELSE 'below'
    END
  ) AS "status"
FROM "phones";

SELECT avg("price") FROM "phones";

-- порахувати телефони з ціною більше 10000
SELECT sum(
  CASE
    WHEN "price" > 10000 THEN 1
    ELSE 0
  END
)
FROM "phones";