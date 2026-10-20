-- vw_delivery_performance
-- One row per delivery with partner, store and area context.
-- SLA threshold: 30 minutes from pickup to drop-off.

CREATE OR REPLACE VIEW vw_delivery_performance AS
SELECT
    d.delivery_id,
    d.order_id,
    d.partner_id,
    dp.partner_name,
    dp.vehicle_type,
    dp.partner_status,
    o.store_id,
    ds.store_code,
    sa.area_name                                                AS store_area,
    d.pickup_time,
    d.delivered_time,
    TIMESTAMPDIFF(MINUTE, d.pickup_time, d.delivered_time)      AS delivery_minutes,
    d.distance_km,
    d.delivery_status,
    CASE WHEN TIMESTAMPDIFF(MINUTE, d.pickup_time, d.delivered_time) <= 30
         THEN 1 ELSE 0 END                                      AS within_sla,
    CASE WHEN d.delivery_status = 'Delayed' THEN 1 ELSE 0 END   AS is_delayed
FROM Deliveries d
JOIN Delivery_Partners dp ON dp.partner_id = d.partner_id
JOIN Orders o             ON o.order_id    = d.order_id
JOIN Dark_Stores ds       ON ds.store_id   = o.store_id
JOIN Areas sa             ON sa.area_id    = ds.area_id;
