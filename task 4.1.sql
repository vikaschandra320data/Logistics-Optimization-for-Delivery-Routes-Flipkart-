● Find the top 3 warehouses with the highest average processing time. 
SELECT
  warehouse_id,
  warehouse_name,
  ROUND(AVG(average_processing_time_min),2) AS avg_processing_time_min, COUNT(*) AS rows_count
FROM Warehouses
GROUP BY warehouse_id, warehouse_name
ORDER BY avg_processing_time_min DESC
LIMIT 3;
