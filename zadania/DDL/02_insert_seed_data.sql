-- 02_insert_seed_data.sql
-- Cel: zaladowac przykladowe dane do pustej bazy.
-- ON CONFLICT DO NOTHING pozwala bezpiecznie uruchomic skrypt drugi raz bez duplikatow.

INSERT INTO course.customers (
    customer_id,
    customer_name,
    email,
    country,
    signup_date,
    acquisition_channel
)
VALUES
    (1, 'Anna Kowalska', 'anna.kowalska@example.com', 'PL', '2026-01-05', 'google'),
    (2, 'Jan Nowak', 'jan.nowak@example.com', 'PL', '2026-01-12', 'facebook'),
    (3, 'Maria Schmidt', 'maria.schmidt@example.com', 'DE', '2026-02-01', 'organic'),
    (4, 'Peter Mueller', 'peter.mueller@example.com', 'DE', '2026-02-10', 'google'),
    (5, 'Eva Novak', 'eva.novak@example.com', 'CZ', '2026-03-03', 'newsletter'),
    (6, 'Claire Dupont', 'claire.dupont@example.com', 'FR', '2026-03-15', 'facebook'),
    (7, 'Tomasz Zielinski', NULL, 'PL', '2026-04-02', 'organic'),
    (8, 'Laura Martin', 'laura.martin@example.com', 'FR', '2026-04-08', 'google')
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO course.products (
    product_id,
    product_name,
    category,
    base_price
)
VALUES
    (101, 'SQL Basics Course', 'course', 120.00),
    (102, 'Python Starter Course', 'course', 150.00),
    (103, 'Data Engineering Ebook', 'ebook', 49.99),
    (104, 'PostgreSQL Cheatsheet', 'ebook', 19.99),
    (105, 'Analytics Mentoring Session', 'mentoring', 250.00),
    (106, 'Dashboard Template', 'template', 79.00),
    (107, 'Airflow Mini Course', 'course', 180.00),
    (108, 'dbt Mini Course', 'course', 170.00)
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO course.orders (
    order_id,
    customer_id,
    order_date,
    status,
    total_amount
)
VALUES
    (1001, 1, '2026-05-01', 'paid', 169.99),
    (1002, 2, '2026-05-02', 'paid', 120.00),
    (1003, 3, '2026-05-03', 'pending', 250.00),
    (1004, 1, '2026-05-05', 'paid', 79.00),
    (1005, 4, '2026-05-06', 'cancelled', 150.00),
    (1006, 5, '2026-05-08', 'paid', 199.99),
    (1007, 6, '2026-05-10', 'paid', 49.99),
    (1008, 2, '2026-05-11', 'paid', 250.00),
    (1009, 7, '2026-05-13', 'pending', 180.00),
    (1010, 8, '2026-05-14', 'paid', 170.00),
    (1011, 3, '2026-05-16', 'paid', 99.99),
    (1012, 1, '2026-05-18', 'cancelled', 180.00)
ON CONFLICT (order_id) DO NOTHING;

INSERT INTO course.order_items (
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
    (1, 1001, 101, 1, 120.00),
    (2, 1001, 103, 1, 49.99),
    (3, 1002, 101, 1, 120.00),
    (4, 1003, 105, 1, 250.00),
    (5, 1004, 106, 1, 79.00),
    (6, 1005, 102, 1, 150.00),
    (7, 1006, 102, 1, 150.00),
    (8, 1006, 103, 1, 49.99),
    (9, 1007, 103, 1, 49.99),
    (10, 1008, 105, 1, 250.00),
    (11, 1009, 107, 1, 180.00),
    (12, 1010, 108, 1, 170.00),
    (13, 1011, 104, 5, 19.99),
    (14, 1012, 107, 1, 180.00)
ON CONFLICT (order_item_id) DO NOTHING;
