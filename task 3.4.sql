● Recommend potential routes for optimization. 
CREATE TEMPORARY TABLE tmp_route_stats AS
SELECT
  r.route_id,
  r.start_location,
  r.end_location,
  r.distance_km,
  r.average_travel_time_min,
  COUNT(o.order_id) AS orders_count,
  ROUND(AVG(o.delivery_delay_days),2) AS avg_delay_days,
  ROUND(100.0 * SUM(CASE WHEN o.delivery_delay_days > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(o.order_id),0),2) AS pct_delayed,
  ROUND(AVG(r.traffic_delay_min),2) AS avg_traffic_delay_min,
  ROUND(
    CASE WHEN r.average_travel_time_min IS NULL OR r.average_travel_time_min = 0 THEN NULL
         ELSE (r.distance_km / r.average_travel_time_min) * 60.0 END
  ,2) AS km_per_hour
FROM Routes r
LEFT JOIN orders_clean o ON r.route_id = o.route_id
WHERE o.delivery_delay_days IS NOT NULL
GROUP BY r.route_id, r.start_location, r.end_location, r.distance_km, r.average_travel_time_min;

SELECT * FROM tmp_route_stats ORDER BY avg_delay_days DESC LIMIT 5;
