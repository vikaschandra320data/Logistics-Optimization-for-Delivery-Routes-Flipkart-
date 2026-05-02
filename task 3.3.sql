● Find routes with >20% delayed shipments. 

SELECT
  r.route_id,
  r.start_location,
  r.end_location,
  COUNT(o.order_id) AS total_orders,
  SUM(CASE WHEN o.delivery_delay_days > 0 THEN 1 ELSE 0 END) AS delayed_count,
  ROUND(100.0 * SUM(CASE WHEN o.delivery_delay_days > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(o.order_id),0), 2) AS pct_delayed
FROM Routes r
JOIN orders_clean o ON r.route_id = o.route_id
WHERE o.delivery_delay_days IS NOT NULL
GROUP BY r.route_id, r.start_location, r.end_location
HAVING pct_delayed > 20.0
ORDER BY pct_delayed DESC, delayed_count DESC;
