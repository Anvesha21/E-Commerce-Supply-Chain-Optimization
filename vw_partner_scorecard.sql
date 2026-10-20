-- vw_partner_scorecard (NEW)
-- One row per delivery partner, including partners with no deliveries.
-- Flags are only assigned once a partner has at least 5 deliveries,
-- so one bad delivery does not label someone as needing coaching.

CREATE OR REPLACE VIEW vw_partner_scorecard AS
SELECT
    dp.partner_id,
    dp.partner_name,
    dp.vehicle_type,
    dp.partner_status,
    COUNT(dl.delivery_id)                       AS deliveries,
    ROUND(AVG(dl.delivery_minutes), 1)          AS avg_delivery_minutes,
    ROUND(AVG(dl.distance_km), 2)               AS avg_distance_km,
    ROUND(AVG(dl.is_delayed) * 100, 1)          AS delayed_pct,
    ROUND(AVG(cs.rating), 2)                    AS avg_rating,
    CASE
        WHEN COUNT(dl.delivery_id) = 0           THEN 'No activity'
        WHEN COUNT(dl.delivery_id) < 5           THEN 'Low sample'
        WHEN AVG(dl.is_delayed) > 0.5            THEN 'Coaching needed'
        WHEN AVG(dl.is_delayed) > 0.25           THEN 'Watch'
        ELSE 'On track'
    END                                         AS partner_flag
FROM Delivery_Partners dp
LEFT JOIN vw_delivery_performance dl ON dl.partner_id = dp.partner_id
LEFT JOIN vw_customer_satisfaction cs ON cs.order_id  = dl.order_id
GROUP BY dp.partner_id, dp.partner_name, dp.vehicle_type, dp.partner_status;
