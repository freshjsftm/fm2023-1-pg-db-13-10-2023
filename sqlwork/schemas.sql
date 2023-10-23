CREATE SCHEMA "inside";
CREATE TYPE "profession" AS ENUM('hr', 'prog', 'senior prog');

CREATE TABLE "inside"."users"(
  "id" SERIAL PRIMARY KEY,
  "login" VARCHAR(64) NOT NULL UNIQUE CHECK("login"!=''),
  "password" VARCHAR(64) NOT NULL UNIQUE CHECK("password"!='')
);
INSERT INTO "inside"."users"("login", "password")
VALUES ('qaqwe1','qaqwe1'),('qaqwe2','qaqwe2'),('qaqwe3','qaqwe3');

SELECT * FROM "users"; -- schema - public
SELECT * FROM "inside"."users";

CREATE TABLE "inside"."workers"(
  "id" SERIAL PRIMARY KEY,
  "department" VARCHAR(64) NOT NULL CHECK("department"!=''),
  "position" VARCHAR(64) NOT NULL CHECK("position"!=''),
  "user_id" INT REFERENCES "inside"."users"("id"),
  "created_at" DATE NOT NULL DEFAULT current_date
);
ALTER TABLE "inside"."workers"
ADD UNIQUE ("user_id");

INSERT INTO "inside"."workers"("department", "position", "user_id")
VALUES ('qq','hr', 3),('qq','hr', 4),('qq','prog',5),('qq','prog', 6),
('ww','hr', 7),('ww','prog',8);

-- в таблицю "inside"."workers" ALTERом додати нову колонку 
-- salary numeric(7,2) NOT NULL DEFAULT 20000.00
ALTER TABLE "inside"."workers"
ADD COLUMN "salary" NUMERIC(7,2) NOT NULL DEFAULT 20000.00;

-- ALTER TABLE "inside"."workers"
-- ADD COLUMN "pos_prof" TYPE "profession";

SELECT u.*, COALESCE(w.position, 'not work'),  COALESCE(w.salary, 0)
FROM "inside"."users" AS u 
  LEFT JOIN "inside"."workers" AS w ON u."id"=w."user_id";
  
UPDATE "inside"."workers"
SET "salary"=  "salary"*2.8
WHERE "id"=5;


-----  window function
SELECT u.login, w.*, avg(w."salary") OVER (PARTITION BY w.position)
FROM "inside"."users" AS u 
  JOIN "inside"."workers" AS w ON u."id"=w."user_id";