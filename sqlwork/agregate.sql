
/*
max
min
count
sum
avg
*/


SELECT max("height"), "email"
FROM "users";

SELECT avg("height")
FROM "users";


SELECT max("height"), "firstName"
FROM "users"
WHERE "isMale"=FALSE
GROUP BY "firstName"
LIMIT 5;

SELECT count(*), "isMale" 
FROM users
WHERE "isMale"=TRUE
GROUP BY "isMale";


-- середній зріст чоловіків та жінок
SELECT avg("height"), "isMale" 
FROM "users"
GROUP BY "isMale";
-- мінімальна вага чоловіків та жінок
SELECT min("weight") AS "Мінімальна вага", "isMale" 
FROM "users"
GROUP BY "isMale";
-- кількість користувачів, які народилися у 1968 році
SELECT count("id"), extract('years' from "birthday") AS "year"
FROM "users"
-- WHERE extract('years' from "birthday")=1986
GROUP BY "year";
-- кількість користувачів, які мають прізвище Andersen
SELECT count("id"), "lastName"
FROM "users"
WHERE "lastName" = 'Parker'
GROUP BY "lastName";
-- кількість користувачів, які народилися у липні (7)
SELECT count("id"), extract('months' from "birthday") AS "months"
FROM "users"
WHERE  extract('months' from "birthday")=7
GROUP BY "months";
-- загальна вага жінок з іменем Anna
SELECT sum("weight"), "firstName", count(*), "isMale"
FROM "users"
WHERE  "isMale"=FALSE AND "firstName"='Amy'
GROUP BY "firstName", "isMale";
-- кількість чоловіків та жінок, які мають зріст менше 1.5
SELECT count(*), "isMale"
FROM "users"
WHERE  "height"<1.5
GROUP BY "isMale";
-- кількість чоловіків та жінок до 30 років
SELECT count(*), "isMale"
FROM "users"
WHERE  extract('years' from age("birthday")) < 30
GROUP BY "isMale";