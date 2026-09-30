INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Devices and accessories'),
('Home & Kitchen', 'Everyday home products'),
('Books', 'Printed books and guides'),
('Fitness', 'Training and wellness equipment');

INSERT INTO products (category_id, product_name, sku, unit_price, stock_quantity, reorder_level) VALUES
(1, 'Wireless Headphones', 'ELEC-001', 2499.00, 18, 8),
(1, 'Mechanical Keyboard', 'ELEC-002', 3299.00, 6, 8),
(1, 'USB-C Hub', 'ELEC-003', 1499.00, 24, 10),
(2, 'Insulated Water Bottle', 'HOME-001', 799.00, 35, 10),
(2, 'Desk Lamp', 'HOME-002', 1299.00, 4, 6),
(3, 'SQL for Beginners', 'BOOK-001', 599.00, 42, 12),
(3, 'Data Analytics Handbook', 'BOOK-002', 899.00, 17, 8),
(4, 'Yoga Mat', 'FIT-001', 1099.00, 11, 8),
(4, 'Resistance Bands', 'FIT-002', 499.00, 0, 5),
(4, 'Smart Jump Rope', 'FIT-003', 1799.00, 9, 5);

INSERT INTO customers (first_name, last_name, email, phone, city, joined_at, loyalty_points) VALUES
('Aarav', 'Sharma', 'aarav@example.com', '9876543210', 'Mumbai', '2025-01-10 09:30', 120),
('Diya', 'Patel', 'diya@example.com', '9876543211', 'Ahmedabad', '2025-01-18 10:15', 80),
('Kabir', 'Singh', 'kabir@example.com', NULL, 'Delhi', '2025-02-03 14:00', 35),
('Meera', 'Iyer', 'meera@example.com', '9876543213', 'Bengaluru', '2025-02-16 11:20', 210),
('Rohan', 'Das', 'rohan@example.com', NULL, 'Kolkata', '2025-03-02 16:10', 0),
('Sana', 'Khan', 'sana@example.com', '9876543215', 'Pune', '2025-03-10 08:45', 15);

INSERT INTO orders (customer_id, order_date, status, shipping_fee, shipping_city) VALUES
(1, '2025-01-15 12:10', 'completed', 99.00, 'Mumbai'),
(2, '2025-01-23 17:40', 'completed', 0.00, 'Ahmedabad'),
(1, '2025-02-04 09:15', 'completed', 99.00, 'Mumbai'),
(3, '2025-02-12 18:30', 'cancelled', 99.00, 'Delhi'),
(4, '2025-02-22 13:05', 'completed', 0.00, 'Bengaluru'),
(2, '2025-03-01 10:25', 'processing', 99.00, 'Ahmedabad'),
(4, '2025-03-14 15:45', 'completed', 99.00, 'Bengaluru'),
(1, '2025-03-25 19:20', 'completed', 0.00, 'Mumbai');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 2499.00), (1, 6, 1, 599.00),
(2, 2, 1, 3299.00), (2, 4, 2, 799.00),
(3, 3, 2, 1499.00), (3, 8, 1, 1099.00),
(4, 5, 1, 1299.00),
(5, 1, 1, 2499.00), (5, 7, 2, 899.00), (5, 9, 1, 499.00),
(6, 6, 3, 599.00), (6, 10, 1, 1799.00),
(7, 2, 1, 3299.00), (7, 8, 2, 1099.00),
(8, 1, 1, 2499.00), (8, 4, 1, 799.00), (8, 7, 1, 899.00);
