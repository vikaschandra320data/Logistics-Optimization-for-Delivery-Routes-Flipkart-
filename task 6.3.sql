● Identify orders with >2 delayed checkpoints  
SELECT
    order_id,
    COUNT(*) AS delayed_checkpoint_count
FROM Shipment_Tracking
WHERE delay_reason IS NOT NULL
  AND TRIM(delay_reason) <> ''
  AND LOWER(delay_reason) <> 'none'
GROUP BY order_id
HAVING COUNT(*) > 2
ORDER BY delayed_checkpoint_count DESC;
