● Replace null Traffic_Delay_Min with the average delay for that route. 

select * from routes;

UPDATE Routes AS r
JOIN (
    SELECT route_id, AVG(traffic_delay_min) AS avg_traffic_delay
    FROM Routes
    WHERE traffic_delay_min IS NOT NULL
    GROUP BY route_id
) AS ra
ON r.route_id = ra.route_id
SET r.traffic_delay_min = ra.avg_traffic_delay
WHERE r.traffic_delay_min IS NULL
  AND r.route_id IS NOT NULL;
