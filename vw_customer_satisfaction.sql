-- vw_customer_satisfaction
-- One row per customer rating, with sentiment band and the delivery it refers to.
-- Sentiment: 4-5 = Satisfied, 3 = Neutral, 1-2 = Dissatisfied.

CREATE OR REPLACE VIEW vw_customer_satisfaction AS
SELECT
    r.rating_id,
    r.order_id,
    r.customer_id,
    c.customer_type,
    o.store_id,
    ds.store_code,
    r.rating,
    CASE
        WHEN r.rating >= 4 THEN 'Satisfied'
        WHEN r.rating = 3  THEN 'Neutral'
        ELSE 'Dissatisfied'
    END                                                        AS sentiment,
    d.delivery_status,
    TIMESTAMPDIFF(MINUTE, d.pickup_time, d.delivered_time)     AS delivery_minutes,
    r.feedback,
    r.rating_time
FROM Customer_Ratings r
JOIN Customers c    ON c.customer_id = r.customer_id
JOIN Orders o       ON o.order_id    = r.order_id
JOIN Dark_Stores ds ON ds.store_id   = o.store_id
LEFT JOIN Deliveries d ON d.order_id = r.order_id;
