● Use window functions to rank all orders by delay within each warehouse. 

SELECT o.*, 
       ROW_NUMBER() OVER (PARTITION BY warehouse_id ORDER BY delivery_delay_days DESC)
       AS delay_rank_in_warehouse
FROM orders_clean o;
