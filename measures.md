# DAX Measures

Import these views into Power BI: vw_order_summary, vw_delivery_performance,
vw_inventory_status, vw_customer_satisfaction, vw_store_performance,
vw_partner_scorecard. Create relationships on store_id, order_id, product_id,
and partner_id. Put the measures in a dedicated `_Measures` table.

## Revenue and orders

```dax
Total Revenue = SUM ( vw_order_summary[delivered_revenue] )

Total Orders = COUNTROWS ( vw_order_summary )

Delivered Orders = SUM ( vw_order_summary[is_delivered] )

Cancelled Orders = SUM ( vw_order_summary[is_cancelled] )

Average Order Value = DIVIDE ( [Total Revenue], [Delivered Orders] )

Cancellation Rate % = DIVIDE ( [Cancelled Orders], [Total Orders] ) * 100

Revenue Share % =
DIVIDE (
    [Total Revenue],
    CALCULATE ( [Total Revenue], ALL ( vw_order_summary[store_code] ) )
) * 100
```

## Delivery operations

```dax
Deliveries Completed = COUNTROWS ( vw_delivery_performance )

Avg Delivery Minutes = AVERAGE ( vw_delivery_performance[delivery_minutes] )

Avg Distance km = AVERAGE ( vw_delivery_performance[distance_km] )

SLA Compliance % =
DIVIDE ( SUM ( vw_delivery_performance[within_sla] ),
         COUNTROWS ( vw_delivery_performance ) ) * 100

Delayed Deliveries = SUM ( vw_delivery_performance[is_delayed] )

Active Partners =
CALCULATE (
    DISTINCTCOUNT ( vw_partner_scorecard[partner_id] ),
    vw_partner_scorecard[partner_status] = "Active"
)
```

## Customer satisfaction

```dax
Avg Rating = AVERAGE ( vw_customer_satisfaction[rating] )

Satisfaction % =
DIVIDE (
    CALCULATE ( COUNTROWS ( vw_customer_satisfaction ),
                vw_customer_satisfaction[sentiment] = "Satisfied" ),
    COUNTROWS ( vw_customer_satisfaction )
) * 100
```

## Inventory

```dax
-- The original dashboard's "Total Products" card counted inventory rows
-- (store x product pairs), so it showed 16 instead of 10 products.
-- Use a distinct count for products:
Distinct Products = DISTINCTCOUNT ( vw_inventory_status[product_id] )

Inventory Rows = COUNTROWS ( vw_inventory_status )

Avg Stock Available = AVERAGE ( vw_inventory_status[stock_available] )

Critical SKUs = CALCULATE ( COUNTROWS ( vw_inventory_status ),
                            vw_inventory_status[stock_status] = "Critical" )

Warning SKUs = CALCULATE ( COUNTROWS ( vw_inventory_status ),
                           vw_inventory_status[stock_status] = "Warning" )

Stockout Risk % = DIVIDE ( [Critical SKUs] + [Warning SKUs], [Inventory Rows] ) * 100
```

## Data quality

```dax
Failing Checks =
CALCULATE ( COUNTROWS ( vw_data_quality ), vw_data_quality[result] = "FAIL" )
```
