-- EXISTS

SELECT EXISTS(SELECT * FROM users WHERE id=51);

SELECT u."email"
FROM "users" AS u
WHERE EXISTS(
  SELECT * 
  FROM "orders" AS o 
  WHERE u."id"=o."userId"
)

SELECT u."email"
FROM "users" AS u
WHERE NOT EXISTS(
  SELECT * 
  FROM "orders" AS o 
  WHERE u."id"=o."userId"
)

SELECT "email"
FROM "users" 
WHERE "id" IN (SELECT "userId" FROM "orders");

SELECT "email"
FROM "users" 
WHERE "id" NOT IN (SELECT "userId" FROM "orders");

-- ANY/SOME  ALL

SELECT "email"
FROM "users" 
WHERE "id"=SOME(SELECT "userId" FROM "orders");

SELECT "email"
FROM "users" 
WHERE "id"!=ALL(SELECT "userId" FROM "orders");