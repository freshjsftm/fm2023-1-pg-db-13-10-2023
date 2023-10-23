CREATE TYPE "task_status" AS ENUM('done', 'processing', 'pending', 'reject');
CREATE TABLE "users_tasks"(
  "id" BIGSERIAL PRIMARY KEY,
  "body" VARCHAR(256) NOT NULL,
  "user_id" INT REFERENCES "users"("id"),
  "status" "task_status",
  "deadline" TIMESTAMP NOT NULL
);
INSERT INTO "users_tasks"("body", "user_id", "deadline")
VALUES ('body1', 4, '2023-11-11'),
('body2', 3, '2023-11-11'),
('body3', 7, '2023-11-11');



--додаємо нову колонку
ALTER TABLE "users_tasks"
ADD COLUMN "created_at" TIMESTAMP NOT NULL DEFAULT current_timestamp;

--видаляємо нову колонку
ALTER TABLE "users_tasks"
DROP COLUMN "created_at";

--додаємо обмеження
ALTER TABLE "users_tasks"
ADD CONSTRAINT "check_created_at" CHECK("created_at"<=current_timestamp);

ALTER TABLE "users_tasks"
ADD CHECK("created_at"<=current_timestamp);

--видаляємо обмеження
ALTER TABLE "users_tasks"
DROP CONSTRAINT "check_created_at";

ALTER TABLE "users_tasks"
DROP CONSTRAINT "users_tasks_created_at_check";


--встановлюємо NOT NULL
UPDATE "users_tasks"
SET "status"='pending'
WHERE "status" IS NULL;
ALTER TABLE "users_tasks"
ALTER COLUMN "status" SET NOT NULL;

--видаляємо NOT NULL
ALTER TABLE "users_tasks"
ALTER COLUMN "status" DROP NOT NULL;

--встановлюємо DEFAULT
ALTER TABLE "users_tasks"
ALTER COLUMN "status" SET DEFAULT 'pending';
ALTER TABLE "users_tasks"
ALTER COLUMN "deadline" SET DEFAULT current_timestamp;

INSERT INTO "users_tasks"("body", "user_id")
VALUES ('body5', 4),('body6', 4);

--видаляємо DEFAULT
ALTER TABLE "users_tasks"
ALTER COLUMN "deadline" DROP DEFAULT;


--змінюємо тип стовпця
ALTER TABLE "users_tasks"
ALTER COLUMN "body" TYPE TEXT;

--змінюємо назву стовпця
ALTER TABLE "users_tasks"
RENAME COLUMN "body" TO "content";

INSERT INTO "users_tasks"("content", "user_id")
VALUES ('body7', 4),('body8', 4);

--змінюємо назву таблиці
ALTER TABLE "users_tasks" RENAME TO "tasks";

SELECT * FROM "tasks";