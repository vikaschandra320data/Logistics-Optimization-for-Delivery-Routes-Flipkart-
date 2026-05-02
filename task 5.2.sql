● Find agents with on-time % < 80%. 
SELECT
  a.agent_id,
  a.agent_name,
  COUNT(o.order_id) AS total_deliveries,
  SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END) AS ontime_deliveries,
  ROUND(100.0 * SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END) 
        / NULLIF(COUNT(o.order_id),0), 2)      AS ontime_pct
FROM Delivery_Agents a
LEFT JOIN orders_clean o ON a.agent_id = o.agent_id
GROUP BY a.agent_id, a.agent_name
HAVING ontime_pct < 80
ORDER BY ontime_pct ASC, total_deliveries DESC;
