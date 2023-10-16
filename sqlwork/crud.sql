
ALTER TABLE "users"
ADD COLUMN "weight" INT CHECK("weight">0 AND "weight"<=250);

UPDATE "users"
SET "weight"= ("height"-1)*100;

UPDATE "users"
SET "weight"= 60
WHERE "id" IN (1,6,15)
RETURNING *;

--встановити вагу 230 кг усім чоловікам зі зростом більше 1.98
UPDATE "users"
SET "weight"= 230
WHERE "isMale"=TRUE AND "height">1.98
RETURNING *;
--встановити вагу 53 кг усім жінкам зі зростом менше 1.60
UPDATE "users"
SET "weight"= 53
WHERE "isMale"=FALSE AND "height"<1.6
RETURNING *;


UPDATE "users"
SET "lastName"='Qwerty'
WHERE "id"=8
RETURNING *;


INSERT INTO users (
    "firstName",
    "lastName",
    email,
    "isMale",
    birthday,
    height,
    weight
  )
VALUES (
    'Brad',
    'Pitt',
    'pittqwe@gmail.com',
    true,
    '1963-12-18',
    1.87,
    87
  )
  RETURNING *;


  