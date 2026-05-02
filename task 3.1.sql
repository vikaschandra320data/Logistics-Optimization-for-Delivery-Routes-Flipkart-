● For each route, calculate: 
○ Average delivery time (in days). 
○ Average traffic delay. 
○ Distance-to-time efficiency ratio: Distance_KM / Average_Travel_Time_Min.

SELECT
  r.route_id,
  r.start_location,
  r.end_location,
  ROUND(AVG(o.delivery_delay_days), 2) AS avg_delivery_delay_days,
  ROUND(AVG(r.traffic_delay_min), 2) AS avg_traffic_delay_min,
  r.distance_km,
  r.average_travel_time_min,
  ROUND(
    CASE
      WHEN r.average_travel_time_min IS NULL OR r.average_travel_time_min = 0 THEN NULL
      ELSE (r.distance_km / r.average_travel_time_min) * 60.0
    END
  , 2) AS km_per_hour_estimate
FROM Routes r
LEFT JOIN orders_clean o
  ON r.route_id = o.route_id
WHERE o.delivery_delay_days IS NOT NULL   		
GROUP BY
  r.route_id, r.start_location, r.end_location, r.distance_km, r.average_travel_time_min
ORDER BY avg_delivery_delay_days DESC
LIMIT 50;
