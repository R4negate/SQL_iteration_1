-- 04_prepare_join_demo_records.sql
DELETE FROM course.order_items
WHERE order_id IN (1009, 1010, 1012);

DELETE FROM course.orders
WHERE order_id IN (1009, 1010, 1012);

-- Dodajemy klientow bez zamowien.
INSERT INTO course.customers (
    customer_id,
    customer_name,
    email,
    country,
    signup_date,
    acquisition_channel
)
VALUES
    (9, 'Martin Martin', 'martin.martin@example.com', 'FR', '2026-04-08', 'google'),
    (10, 'Customer Without Order', 'no.order@example.com', 'PL', '2026-04-15', 'organic')
ON CONFLICT (customer_id) DO NOTHING;

-- Dodajemy produkty bez sprzedazy.
INSERT INTO course.products (
    product_id,
    product_name,
    category,
    base_price
)
VALUES
    (109, 'Unused SQL Template', 'template', 59.00),
    (110, 'Never Sold Ebook', 'ebook', 39.00)
ON CONFLICT (product_id) DO NOTHING;
