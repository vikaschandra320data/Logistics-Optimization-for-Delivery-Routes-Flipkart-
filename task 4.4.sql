● Rank warehouses based on on-time delivery percentage. 
SELECT
  w.warehouse_id,
  w.warehouse_name,
  COUNT(o.order_id) AS total_shipments,
  SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END) AS ontime_count,
  ROUND(
    100.0 * SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END)
    / NULLIF(COUNT(o.order_id),0)
  , 2) AS ontime_pct,
  RANK() OVER (ORDER BY
    ROUND(
      100.0 * SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END)
      / NULLIF(COUNT(o.order_id),0)
    , 8) DESC) AS ontime_rank
FROM Warehouses w
JOIN orders_clean o ON w.warehouse_id = o.warehouse_id
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY ontime_pct DESC, ontime_count DESC;
