-- vw_data_quality (NEW)
-- Business-rule checks. Each row reports how many records break a rule.
-- Run SELECT * FROM vw_data_quality; after loading data.

CREATE OR REPLACE VIEW vw_data_quality AS
SELECT
    'order_value_matches_items'                  AS check_name,
    COUNT(*)                                     AS failing_rows,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END AS result
FROM vw_order_summary
WHERE ABS(value_gap) > 0.01

UNION ALL

SELECT
    'delivered_order_has_delivery_record',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM vw_order_summary o
LEFT JOIN Deliveries d ON d.order_id = o.order_id
WHERE o.is_delivered = 1 AND d.delivery_id IS NULL

UNION ALL

SELECT
    'cancelled_or_pending_order_has_delivery',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM Deliveries d
JOIN Orders o ON o.order_id = d.order_id
WHERE o.order_status IN ('Cancelled', 'Pending')

UNION ALL

SELECT
    'rating_on_undelivered_order',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM Customer_Ratings r
JOIN Orders o ON o.order_id = r.order_id
WHERE o.order_status <> 'Delivered'

UNION ALL

SELECT
    'rating_customer_matches_order_customer',
    COUNT(*),
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END
FROM Customer_Ratings r
JOIN Orders o ON o.order_id = r.order_id
WHERE r.customer_id <> o.customer_id;
