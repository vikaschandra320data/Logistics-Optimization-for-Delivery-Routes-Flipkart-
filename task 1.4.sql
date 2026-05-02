● Ensure that no Actual_Delivery_Date is before Order_Date (flag such records). 

ALTER TABLE orders_clean ADD COLUMN delivery_date_flag boolean;

UPDATE orders_clean
SET delivery_date_flag = (actual_delivery_date < order_date);

SELECT * FROM orders_clean;

