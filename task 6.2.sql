● Find the most common delay reasons (excluding None). 
SELECT delay_reason, COUNT(*) AS cnt
FROM Shipment_Tracking
WHERE delay_reason IS NOT NULL
  AND TRIM(delay_reason) <> ''
  AND LOWER(delay_reason) <> 'none'
GROUP BY delay_reason
ORDER BY cnt DESC
LIMIT 5;
