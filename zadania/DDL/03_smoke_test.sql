-- 03_smoke_test.sql
-- Cel: szybko sprawdzic, czy baza zostala przygotowana poprawnie.

SELECT current_database() AS database_name;

SELECT schema_name
FROM information_schema.schemata
WHERE schema_name = 'course';

SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema = 'course'
ORDER BY table_name;

SELECT 'customers' AS table_name, COUNT(*) AS rows_count FROM course.customers
UNION ALL
SELECT 'products' AS table_name, COUNT(*) AS rows_count FROM course.products
UNION ALL
SELECT 'orders' AS table_name, COUNT(*) AS rows_count FROM course.orders
UNION ALL
SELECT 'order_items' AS table_name, COUNT(*) AS rows_count FROM course.order_items;

SELECT *
FROM course.orders
ORDER BY order_date
LIMIT 5;

