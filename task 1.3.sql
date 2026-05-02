● Convert all date columns into YYYY-MM-DD format using SQL functions. 

UPDATE orders_clean
SET order_date = STR_TO_DATE(order_date, '%Y-%m-%d')
WHERE order_date IS NOT NULL
  AND STR_TO_DATE(order_date, '%Y-%m-%d') IS NOT NULL;
  
  UPDATE orders_clean
SET expected_delivery_date = STR_TO_DATE(expected_delivery_date, '%Y-%m-%d')
WHERE expected_delivery_date IS NOT NULL
  AND STR_TO_DATE(expected_delivery_date, '%Y-%m-%d') IS NOT NULL;
  
  UPDATE orders_clean
SET actual_delivery_date = STR_TO_DATE(actual_delivery_date, '%Y-%m-%d')
WHERE actual_delivery_date IS NOT NULL
  AND STR_TO_DATE(actual_delivery_date, '%Y-%m-%d') IS NOT NULL;

select * from orders_clean;

