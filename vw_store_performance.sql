-- vw_store_performance
-- One row per dark store. Built on the other views; each CTE aggregates
-- at store level before joining, so counts do not multiply across tables.
-- Requires MySQL 8.0+ (CTEs and window-safe aggregation).

CREATE OR REPLACE VIEW vw_store_performance AS
WITH order_agg AS (
    SELECT
        store_id,
        COUNT(*)                                             AS total_orders,
        SUM(is_delivered)                                    AS delivered_orders,
        SUM(is_cancelled)                                    AS cancelled_orders,
        SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders,
        SUM(delivered_revenue)                               AS delivered_revenue
    FROM vw_order_summary
    GROUP BY store_id
),
delivery_agg AS (
    SELECT
        store_id,
        AVG(delivery_minutes)                                AS avg_delivery_minutes,
        AVG(is_delayed)                                      AS late_rate
    FROM vw_delivery_performance
    GROUP BY store_id
),
rating_agg AS (
    SELECT
        store_id,
        AVG(rating)                                          AS avg_rating
    FROM vw_customer_satisfaction
    GROUP BY store_id
),
stock_agg AS (
    SELECT
        store_id,
        SUM(CASE WHEN stock_status = 'Critical' THEN 1 ELSE 0 END) AS critical_skus,
        SUM(CASE WHEN stock_status = 'Warning'  THEN 1 ELSE 0 END) AS warning_skus
    FROM vw_inventory_status
    GROUP BY store_id
)
SELECT
    ds.store_id,
    ds.store_code,
    ar.area_name                                             AS store_area,
    ds.operating_status,
    ds.capacity_per_hour,
    COALESCE(oa.total_orders, 0)                             AS total_orders,
    COALESCE(oa.delivered_orders, 0)                         AS delivered_orders,
    COALESCE(oa.cancelled_orders, 0)                         AS cancelled_orders,
    COALESCE(oa.pending_orders, 0)                           AS pending_orders,
    ROUND(COALESCE(oa.delivered_revenue, 0), 2)              AS delivered_revenue,
    ROUND(COALESCE(oa.delivered_revenue, 0)
          / NULLIF(oa.delivered_orders, 0), 2)               AS avg_order_value,
    ROUND(COALESCE(oa.cancelled_orders, 0)
          / NULLIF(oa.total_orders, 0) * 100, 1)             AS cancellation_rate_pct,
    ROUND(da.avg_delivery_minutes, 1)                        AS avg_delivery_minutes,
    ROUND(da.late_rate * 100, 1)                             AS late_delivery_pct,
    ROUND(ra.avg_rating, 2)                                  AS avg_rating,
    COALESCE(sa.critical_skus, 0)                            AS critical_skus,
    COALESCE(sa.warning_skus, 0)                             AS warning_skus
FROM Dark_Stores ds
JOIN Areas ar           ON ar.area_id   = ds.area_id
LEFT JOIN order_agg oa    ON oa.store_id = ds.store_id
LEFT JOIN delivery_agg da ON da.store_id = ds.store_id
LEFT JOIN rating_agg ra   ON ra.store_id = ds.store_id
LEFT JOIN stock_agg sa    ON sa.store_id = ds.store_id;
