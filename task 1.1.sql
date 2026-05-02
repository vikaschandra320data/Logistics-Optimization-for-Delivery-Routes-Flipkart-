● Identify and delete duplicate Order_ID records. 

CREATE TABLE orders_clean LIKE Orders;
INSERT INTO orders_clean SELECT * FROM Orders;

 select * from orders_clean;

 SELECT COUNT(*) AS total_rows, COUNT(DISTINCT order_id) AS distinct_orders
FROM orders_clean;
SELECT COUNT(*) AS order_ids_with_duplicates
FROM (
  SELECT order_id
  FROM Orders_clean
  GROUP BY order_id
  HAVING COUNT(*) > 1
) t;

