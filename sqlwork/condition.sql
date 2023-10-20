--COALESCE

UPDATE "phones"
SET "description"='description'
WHERE "price"<7000;

SELECT "model", 
  COALESCE("description", 'not info') 
FROM "phones";


--NULLIF (неявно приводить до типу число)

SELECT NULLIF(12,12); --NULL
SELECT NULLIF(NULL,NULL); --NULL
SELECT NULLIF(NULL,12); --NULL
SELECT NULLIF(45,12);  --45