-- verify.sql
-- Run after schema, seed data, and all views are loaded.
-- Each query lists the expected result in the comment above it.

-- Expected: 10 orders
SELECT COUNT(*) AS total_orders FROM vw_order_summary;

-- Expected: 3362.75 (sum of order_value for the 7 delivered orders)
SELECT ROUND(SUM(delivered_revenue), 2) AS delivered_revenue FROM vw_order_summary;

-- Expected: 7 deliveries, average 28.14 minutes, average 4.79 km
SELECT COUNT(*) AS deliveries,
       ROUND(AVG(delivery_minutes), 2) AS avg_minutes,
       ROUND(AVG(distance_km), 2)      AS avg_km
FROM vw_delivery_performance;

-- Expected: DS004 has 2 delivered orders and 1451.65 delivered revenue
SELECT store_code, delivered_orders, delivered_revenue, avg_order_value
FROM vw_store_performance
WHERE store_code = 'DS004';

-- Expected: 16 inventory rows; 1 Critical (DS006 Aavin Milk), 1 Warning (DS002 Aavin Milk)
SELECT stock_status, COUNT(*) AS rows_in_band
FROM vw_inventory_status
GROUP BY stock_status;

-- Expected: average stock 88.44 across 16 rows
SELECT ROUND(AVG(stock_available), 2) AS avg_stock FROM vw_inventory_status;

-- Expected: 5 rows. order_value_matches_items is FAIL with 10 failing rows,
-- because the seed data's order totals do not match their line items.
-- The other four checks should PASS.
SELECT * FROM vw_data_quality;
