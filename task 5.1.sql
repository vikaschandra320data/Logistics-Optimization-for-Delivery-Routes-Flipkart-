● Rank agents (per route) by on-time delivery percentage  
WITH agent_route_stats AS (
    SELECT
        o.route_id,
        o.agent_id,
        a.agent_name,
        COUNT(o.order_id) AS total_deliveries,
        SUM(o.delivery_delay_days <= 0) AS ontime_deliveries,
        ROUND(
            100.0 * SUM(o.delivery_delay_days <= 0) / NULLIF(COUNT(o.order_id),0),
            2
        ) AS ontime_pct
    FROM orders_clean o
    JOIN Delivery_Agents a ON o.agent_id = a.agent_id
    WHERE o.delivery_delay_days IS NOT NULL
    GROUP BY o.route_id, o.agent_id, a.agent_name
)

SELECT
    route_id,
    agent_id,
    agent_name,
    total_deliveries,
    ontime_deliveries,
    ontime_pct,
    RANK() OVER (PARTITION BY route_id ORDER BY ontime_pct DESC) AS agent_rank_within_route
FROM agent_route_stats
ORDER BY route_id, agent_rank_within_route;
