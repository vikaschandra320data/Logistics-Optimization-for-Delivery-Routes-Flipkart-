● Calculate delivery delay (in days) for each order 

ALTER TABLE orders_clean
ADD COLUMN delivery_delay_days INT NULL;

UPDATE orders_clean
SET delivery_delay_days = DATEDIFF(actual_delivery_date, expected_delivery_date)
WHERE actual_delivery_date IS NOT NULL
  AND expected_delivery_date IS NOT NULL;
  
  select Order_ID, Order_Date, Expected_Delivery_Date, Actual_Delivery_Date, 
  delivery_delay_days from orders_clean;
  