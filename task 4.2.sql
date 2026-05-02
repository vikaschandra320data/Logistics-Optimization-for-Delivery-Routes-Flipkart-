● Calculate total vs. delayed shipments for each warehouse. 
SELECT
    w.warehouse_id,
    w.warehouse_name,
    COUNT(o.order_id) AS total_shipments,
    SUM(o.delivery_delay_days > 0) AS delayed_shipments,
    ROUND(
        100.0 * SUM(o.delivery_delay_days > 0) / NULLIF(COUNT(o.order_id), 0),
        2
    ) AS pct_delayed
FROM Warehouses w
JOIN orders_clean o 
    ON w.warehouse_id = o.warehouse_id
WHERE o.delivery_delay_days IS NOT NULL
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY delayed_shipments DESC, pct_delayed DESC;
