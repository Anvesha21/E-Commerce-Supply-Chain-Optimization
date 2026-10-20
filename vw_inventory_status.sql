-- vw_inventory_status
-- One row per store x product.
-- Stock bands (assumption, tune to your business):
--   Critical : stock <= 50% of reorder level
--   Warning  : stock <= 125% of reorder level
--   Safe     : everything above

CREATE OR REPLACE VIEW vw_inventory_status AS
SELECT
    inv.inventory_id,
    ds.store_id,
    ds.store_code,
    sa.area_name                                         AS store_area,
    p.product_id,
    p.product_name,
    p.category,
    inv.stock_available,
    inv.reorder_level,
    ROUND(inv.stock_available / NULLIF(inv.reorder_level, 0), 2) AS cover_ratio,
    CASE
        WHEN inv.stock_available <= inv.reorder_level * 0.5  THEN 'Critical'
        WHEN inv.stock_available <= inv.reorder_level * 1.25 THEN 'Warning'
        ELSE 'Safe'
    END                                                  AS stock_status,
    inv.last_restocked,
    DATEDIFF(CURDATE(), inv.last_restocked)              AS days_since_restock
FROM Inventory inv
JOIN Dark_Stores ds ON ds.store_id   = inv.store_id
JOIN Areas sa       ON sa.area_id    = ds.area_id
JOIN Products p     ON p.product_id  = inv.product_id;
