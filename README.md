# E-Commerce SQL Mini Project

A PostgreSQL mini project for analysing top products, customer spending, and order trends. It demonstrates the SQL concepts from the course syllabus: filtering, sorting, aliases, NULL handling, aggregates, grouping, joins, `CASE`, date/string functions, and DDL constraints.

## Project questions

1. Which products create the most revenue?
2. Which customers spend the most, and who has not ordered yet?
3. How do completed orders and sales change month to month?
4. Which categories are performing best?
5. Which products are below the reorder point?

## Database design

```text
customers 1 ──< orders 1 ──< order_items >── 1 products >── 1 categories
```

## Run it

Use PostgreSQL and run the scripts in this order:

```sql
\i sql/01_schema.sql
\i sql/02_sample_data.sql
\i sql/03_analysis.sql
```

`03_analysis.sql` contains independent, labelled queries. Run all of it or execute individual sections in pgAdmin, DBeaver, or `psql`.

## Files

- `sql/01_schema.sql` — database tables, keys, checks, indexes, and an `ALTER TABLE` example.
- `sql/02_sample_data.sql` — realistic sample categories, products, customers, orders, and line items.
- `sql/03_analysis.sql` — answers to the project questions plus syllabus demonstrations.

## Key findings from the included sample data

The analytics script calculates these directly rather than hard-coding them. It identifies revenue leaders, high-value customers, monthly growth, category-level performance, unpurchased products, customers without orders, and low-stock products.

## Notes

- Monetary values use `NUMERIC(12,2)` to avoid floating-point rounding errors.
- An order's item price is copied to `order_items.unit_price`, preserving historical selling price when a product's current price changes.
- Cancelled orders are excluded from revenue measures.

## Author

Mini Project — SQL Phase 2
