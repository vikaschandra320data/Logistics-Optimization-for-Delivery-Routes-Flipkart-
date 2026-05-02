● Find Top 10 delayed routes based on average delay days. 

SELECT r.route_id, r.start_location, r.end_location,
       ROUND(AVG(o.delivery_delay_days),2) AS avg_delay_days,
       COUNT(*) AS orders_count
FROM orders_clean o
JOIN Routes r ON o.route_id = r.route_id
GROUP BY r.route_id, r.start_location, r.end_location
ORDER BY avg_delay_days DESC
LIMIT 10;
