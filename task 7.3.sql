Average Traffic Delay per Route. 
SELECT
  r.route_id,
  r.start_location,
  r.end_location,
  COUNT(*) AS route_rows,
  ROUND(AVG(r.traffic_delay_min), 2) AS avg_traffic_delay_min
FROM Routes r
WHERE r.traffic_delay_min IS NOT NULL
GROUP BY r.route_id, r.start_location, r.end_location
ORDER BY avg_traffic_delay_min DESC;
