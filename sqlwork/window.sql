-- , sum(pto.quantity*p.price)
SELECT u."email",p.id, pto.quantity, 
  count(pto.quantity) OVER (PARTITION BY u.id ORDER BY p.id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 
  sum(pto.quantity*p.price) OVER (PARTITION BY u.id),
  sum(pto.quantity*p.price) OVER (PARTITION BY p.id)
FROM "users" AS u
  JOIN "orders" AS o ON u."id"=o."userId"
  JOIN "phones_to_orders" AS pto ON o."id"=pto."orderId"
  JOIN "phones" AS p ON pto."phoneId"=p."id"


-- вивести модель, ціна, бренд і середню ціну по бренду
SELECT model, price, brand, avg(price) OVER (PARTITION BY brand ORDER BY price ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM phones
