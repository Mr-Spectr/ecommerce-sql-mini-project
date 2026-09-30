-- Run after 01_schema.sql and 02_sample_data.sql.

-- 1. SELECT, WHERE, ORDER BY, LIMIT, aliases: active premium products.
SELECT product_name AS product, unit_price AS price, stock_quantity AS stock
FROM products
WHERE is_active = TRUE AND unit_price >= 1000
ORDER BY unit_price DESC
LIMIT 5;

-- 2. NULL handling: show a friendly value when a phone number is absent.
SELECT first_name || ' ' || last_name AS customer,
       COALESCE(phone, 'Not provided') AS phone_number,
       NULLIF(loyalty_points, 0) AS non_zero_loyalty_points
FROM customers
ORDER BY customer;

-- 3. Top products by completed-order revenue.
SELECT p.product_name,
       c.category_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS product_revenue
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
JOIN categories c ON c.category_id = p.category_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name, c.category_name
HAVING SUM(oi.quantity * oi.unit_price) > 1000
ORDER BY product_revenue DESC;

-- 4. Customer spend, including customers who have placed no order (LEFT JOIN).
SELECT cu.customer_id,
       cu.first_name || ' ' || cu.last_name AS customer,
       COUNT(DISTINCT o.order_id) FILTER (WHERE o.status = 'completed') AS completed_orders,
       COALESCE(SUM(oi.quantity * oi.unit_price) FILTER (WHERE o.status = 'completed'), 0) AS lifetime_spend,
       CASE
         WHEN COALESCE(SUM(oi.quantity * oi.unit_price) FILTER (WHERE o.status = 'completed'), 0) >= 5000 THEN 'Gold'
         WHEN COALESCE(SUM(oi.quantity * oi.unit_price) FILTER (WHERE o.status = 'completed'), 0) > 0 THEN 'Active'
         ELSE 'New'
       END AS customer_segment
FROM customers cu
LEFT JOIN orders o ON o.customer_id = cu.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name
ORDER BY lifetime_spend DESC, customer;

-- 5. Monthly order trend with date/time functions.
SELECT TO_CHAR(DATE_TRUNC('month', order_date), 'Mon YYYY') AS month,
       COUNT(*) FILTER (WHERE status = 'completed') AS completed_orders,
       SUM(CASE WHEN status = 'completed' THEN shipping_fee ELSE 0 END) AS shipping_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);

-- 6. Monthly product sales and average order value.
SELECT DATE_TRUNC('month', o.order_date)::DATE AS month,
       COUNT(DISTINCT o.order_id) AS orders,
       SUM(oi.quantity * oi.unit_price) AS sales,
       ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month;

-- 7. Category performance.
SELECT c.category_name,
       COUNT(DISTINCT o.order_id) AS completed_orders,
       COALESCE(SUM(oi.quantity), 0) AS units_sold,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS revenue,
       ROUND(COALESCE(AVG(oi.unit_price), 0), 2) AS average_item_price
FROM categories c
LEFT JOIN products p ON p.category_id = c.category_id
LEFT JOIN order_items oi ON oi.product_id = p.product_id
LEFT JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'completed' OR o.order_id IS NULL
GROUP BY c.category_id, c.category_name
ORDER BY revenue DESC;

-- 8. Products never included in an order (RIGHT JOIN demonstration).
SELECT p.product_name, p.sku, p.stock_quantity
FROM order_items oi
RIGHT JOIN products p ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL
ORDER BY p.product_name;

-- 9. FULL OUTER JOIN: products and order-item relationship audit.
SELECT COALESCE(p.product_name, 'Missing product') AS product,
       oi.order_id,
       oi.quantity
FROM products p
FULL OUTER JOIN order_items oi ON oi.product_id = p.product_id
ORDER BY product, oi.order_id;

-- 10. Inventory action list using CASE.
SELECT product_name, stock_quantity, reorder_level,
       CASE
         WHEN stock_quantity = 0 THEN 'Out of stock'
         WHEN stock_quantity <= reorder_level THEN 'Reorder now'
         ELSE 'Sufficient stock'
       END AS inventory_status
FROM products
ORDER BY stock_quantity, product_name;

-- 11. Customers who have never ordered (IS NULL).
SELECT cu.first_name || ' ' || cu.last_name AS customer, cu.email
FROM customers cu
LEFT JOIN orders o ON o.customer_id = cu.customer_id
WHERE o.order_id IS NULL;
