● Identify 3 routes with the worst efficiency ratio. 

SELECT
  route_id,
  start_location,
  end_location,
  distance_km,
  average_travel_time_min,
  ROUND( CASE
    WHEN average_travel_time_min IS NULL OR average_travel_time_min = 0 THEN NULL
    ELSE (distance_km / average_travel_time_min) * 60.0
  END, 2) AS km_per_hour
FROM Routes
ORDER BY km_per_hour ASC
LIMIT 3;
