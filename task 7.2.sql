On-Time Delivery % = (Total On-Time Deliveries / Total Deliveries) * 100. 
SELECT
  COUNT(*) AS total_deliveries,
  SUM(CASE WHEN delivery_delay_days IS NOT NULL AND delivery_delay_days <= 0 THEN 1 ELSE 0 END) AS ontime_count,
  ROUND(100.0 * SUM(CASE WHEN delivery_delay_days IS NOT NULL AND delivery_delay_days <= 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS ontime_pct
FROM orders_clean;
