
CREATE TABLE "restorans"(
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(128),
  "address" JSONB
);

INSERT INTO "restorans"("name", "address")
VALUES ('Qwe', '{"country":"Ukraine", "town":"Dnipro", "street": "Asdfg"}');

INSERT INTO "restorans"("name", "address")
VALUES ('ASD', '{"country":"Ukraine", "town":"Dnipro", "street": "Asdfg", "house":{"ap":45, "flour":3, "something": true}}');
