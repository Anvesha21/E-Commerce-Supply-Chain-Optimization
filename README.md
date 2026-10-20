# -E-Commerce-Supply-Chain-Optimization
# Quick Commerce Analytics Platform

MySQL & Power BI analytics project for a dark-store delivery service in Coimbatore. It models orders, deliveries, inventory, and customer ratings, and provides views and DAX measures for building interactive dashboards.

## Attribution

The base schema and seed data are taken from the MIT-licensed project by Kowsekhan K R. The original license is in `LICENSE.txt`. This version includes additional views, DAX measures, data quality rules, partner scorecard, stock statuses logic, and tests provided in this repository.

## Setup (MySQL 8.0 or higher)

Run the scripts in the following order:

1. `database/01_schema.sql` – creates database and tables.
2. `database/02_seed_data.sql` – loads seed data.
3. Run all files in `views/` in the following order: start with `vw_order_summary`, `vw_delivery_performance`, `vw_inventory_status`, and `vw_customer_satisfaction`, since `vw_store_performance`, `vw_partner_scorecard`, and `vw_data_quality` rely on them.
4. `tests/verify.sql` – runs tests and compares the result against expected values specified in comments.

## Views

| View Name | Grain | Answered by the view |
|---|---|---|
| `vw_order_summary` | One row per order | Order revenue, order status, and consistency of order totals and their line items |
| `vw_delivery_performance` | One row per delivery | Delivery duration, SLA compliance (30 min), and delays |
| `vw_inventory_status` | One row per store and product | Stock bands: critical, warning, or safe |
| `vw_customer_satisfaction` | One row per rating | Sentiment, and the corresponding delivery |
| `vw_store_performance` | One row per store | Revenue, AOV, cancellation rate, late rate, rating, and stock risk |
| `vw_partner_scorecard` *(new)* | One row per partner | Partner delay rate, speed, and rating with coaching flags |
| `vw_data_quality` *(new)* | One row per business rule | PASS or FAIL on business rules validation |

## Business rules and assumptions

- **SLA** is considered complied if the duration between pickup and drop off does not exceed 30 minutes.
- **Stock bands**: critical – at or below 50% of reorder level; warning – at or below 125%; safe – above that. Set the multipliers in `vw_inventory_status.sql` according to your own stock band policy.
- **Partner flags**: a partner should have at least 5 deliveries to get a Watch or Coaching flag.
- **Revenue** is counted only from orders with status "Delivered".
Known data problem

Orders.order_value does not match the total value of Order_Items.item_total for any order in the seed data. For instance, Order 1 has a value of 420.50, while its items total to 222.00. This problem has been noted by vw_data_quality. Fix this either by changing the seed data or finding out which column should be used as the source of truth and updating the views.

Power BI

Import the above mentioned views, use the relationships from dax/measures.md, and create measures using the dax file. The “Total Products” card on the original dashboard shows 16 numbers corresponding to number of store-product combinations. Distinct Products measure in the dax file returns the correct result of 10.

Project structure

quickcommerce-analytics/
├── LICENSE.txt
├── README.md
├── database/
│   ├── 01_schema.sql
│   └── 02_seed_data.sql
├── views/
│   ├── vw_order_summary.sql
│   ├── vw_delivery_performance.sql
│   ├── vw_inventory_status.sql
│   ├── vw_customer_satisfaction.sql
│   ├── vw_store_performance.sql
│   ├── vw_partner_scorecard.sql
│   └── vw_data_quality.sql
├── dax/
│   └── measures.md
└── tests/
    └── verify.sql

Ideas for extending the project

- Create 60-90 days of simulated orders so that the trend and forecast measures are valid. Right now, there is one day's worth of seed data.
- Create a trend measure of time-based SLA breach, joining Traffic_Conditions and Weather_Impact on area and hour.
- Create a reorder recommendation view estimating the stock needed for covering demand until next stock up.
