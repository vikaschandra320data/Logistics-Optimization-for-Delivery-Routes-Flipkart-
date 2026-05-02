Calculate KPIs using SQL queries: 
Average Delivery Delay per Region (Start_Location). 
On-Time Delivery % = (Total On-Time Deliveries / Total Deliveries) * 100. 
Average Traffic Delay per Route.

Avg delivery delay per region (Start_Location)

SELECT
  r.start_location AS region,
  COUNT(o.order_id) AS orders_count,
  ROUND(AVG(o.delivery_delay_days), 2) AS avg_delay_days
FROM orders_clean o
JOIN Routes r ON o.route_id = r.route_id
WHERE o.delivery_delay_days IS NOT NULL
GROUP BY r.start_location
ORDER BY avg_delay_days DESC, orders_count DESC;
