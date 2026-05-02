● For each order, list the last checkpoint and time. 
SELECT
    st.order_id,
    st.checkpoint AS last_checkpoint,
    st.checkpoint_time AS last_checkpoint_time
FROM Shipment_Tracking st
JOIN (
    SELECT
        order_id,
        MAX(checkpoint_time) AS max_checkpoint_time
    FROM Shipment_Tracking
    GROUP BY order_id
) AS latest
    ON st.order_id = latest.order_id
   AND st.checkpoint_time = latest.max_checkpoint_time
ORDER BY st.order_id;
