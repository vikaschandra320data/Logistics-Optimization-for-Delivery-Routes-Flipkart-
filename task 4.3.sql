● Use CTEs to find bottleneck warehouses where processing time > global average. 
WITH warehouse_avg AS (
  SELECT
    warehouse_id,
    warehouse_name,
    AVG(average_processing_time_min) AS wh_avg_processing_min,
    COUNT(*) AS rows_count
  FROM Warehouses
  WHERE average_processing_time_min IS NOT NULL
  GROUP BY warehouse_id, warehouse_name
),
global_avg AS (
  SELECT AVG(average_processing_time_min) AS global_avg_processing_min
  FROM Warehouses
  WHERE average_processing_time_min IS NOT NULL
)
SELECT
  wa.warehouse_id,
  wa.warehouse_name,
  ROUND(wa.wh_avg_processing_min,2) AS wh_avg_processing_min,
  ROUND(ga.global_avg_processing_min,2) AS global_avg_processing_min,
  wa.rows_count
FROM warehouse_avg wa
CROSS JOIN global_avg ga
WHERE wa.wh_avg_processing_min > ga.global_avg_processing_min
ORDER BY wa.wh_avg_processing_min DESC;
