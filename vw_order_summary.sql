-- vw_order_summary
-- One row per order. Joins customer and dark store, rolls up order items,
-- and flags whether the stored order_value agrees with its line items.

CREATE OR REPLACE VIEW vw_order_summary AS
SELECT
    o.order_id,
    o.order_time,
    DATE(o.order_time)                                    AS order_date,
    HOUR(o.order_time)                                    AS order_hour,
    o.customer_id,
    c.customer_type,
    o.store_id,
    ds.store_code,
    sa.area_name                                          AS store_area,
    o.payment_method,
    o.order_status,
    o.order_value,
    COALESCE(i.items_total, 0)                            AS items_total,
    COALESCE(i.units_sold, 0)                             AS units_sold,
    COALESCE(i.line_count, 0)                             AS line_count,
    ROUND(o.order_value - COALESCE(i.items_total, 0), 2)  AS value_gap,
    CASE WHEN o.order_status = 'Delivered' THEN o.order_value ELSE 0 END AS delivered_revenue,
    CASE WHEN o.order_status = 'Delivered' THEN 1 ELSE 0 END             AS is_delivered,
    CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END             AS is_cancelled
FROM Orders o
JOIN Customers c    ON c.customer_id = o.customer_id
JOIN Dark_Stores ds ON ds.store_id   = o.store_id
JOIN Areas sa       ON sa.area_id    = ds.area_id
LEFT JOIN (
    SELECT order_id,
           SUM(item_total) AS items_total,
           SUM(quantity)   AS units_sold,
           COUNT(*)        AS line_count
    FROM Order_Items
    GROUP BY order_id
) i ON i.order_id = o.order_id;
