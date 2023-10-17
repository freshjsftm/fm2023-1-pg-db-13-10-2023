-- LIKE  ILIKE  NOT LIKE  NOT ILIKE
-- ~~    ~~*     !~~       !~~*
SELECT "id", "firstName", "lastName"
FROM "users"
WHERE "firstName" LIKE 'Al%'
ORDER BY "firstName", "lastName";

-- знайти людей з ініціалами AC
SELECT "id", "firstName", "lastName"
FROM "users"
WHERE "firstName" ~~* 'a%' 
AND "lastName" ~~* 'c%';

--SIMILAR TO
SELECT "id", "firstName", "lastName"
FROM "users"
WHERE "firstName" SIMILAR TO '%(b|m|n){2}%'
ORDER BY "firstName", "lastName";



