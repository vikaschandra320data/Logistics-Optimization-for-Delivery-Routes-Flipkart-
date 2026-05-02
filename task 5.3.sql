● Compare average speed of top 5 vs bottom 5 agents using subqueries. 

WITH agent_scores AS (
  SELECT
    a.agent_id,
    a.agent_name,
    a.avg_speed_kmph,  -- assumes this column exists in Delivery_Agents
    COUNT(o.order_id) AS total_deliveries,
    ROUND(
      100.0 * SUM(CASE WHEN o.delivery_delay_days IS NOT NULL AND o.delivery_delay_days <= 0 THEN 1 ELSE 0 END) 
      / NULLIF(COUNT(o.order_id),0), 2
    ) AS ontime_pct
  FROM Delivery_Agents a
  LEFT JOIN orders_clean o ON a.agent_id = o.agent_id
  GROUP BY a.agent_id, a.agent_name, a.avg_speed_kmph)
SELECT grp, avg_speed_kmph, n_agents
FROM (
  SELECT 'top5' AS grp,
         ROUND(AVG(s.avg_speed_kmph), 2) AS avg_speed_kmph,
         COUNT(*) AS n_agents
  FROM (
    SELECT * 
    FROM agent_scores
    WHERE avg_speed_kmph IS NOT NULL
    ORDER BY ontime_pct DESC, total_deliveries DESC
    LIMIT 5
  ) s
  UNION ALL
SELECT 'bottom5' AS grp,
         ROUND(AVG(s.avg_speed_kmph), 2) AS avg_speed_kmph,
         COUNT(*) AS n_agents
  FROM (
    SELECT *
    FROM agent_scores
    WHERE avg_speed_kmph IS NOT NULL
    ORDER BY ontime_pct ASC, total_deliveries DESC
    LIMIT 5
  ) s
) t;
