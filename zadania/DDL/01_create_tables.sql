-- 01_create_tables.sql
-- Cel: stworzyc tabele potrzebne do pierwszych cwiczen SQL.

CREATE TABLE IF NOT EXISTS course.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    country VARCHAR(2) NOT NULL,
    signup_date DATE NOT NULL,
    acquisition_channel VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS course.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    base_price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS course.orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES course.customers(customer_id)
);

CREATE TABLE IF NOT EXISTS course.order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
        REFERENCES course.orders(order_id),
    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES course.products(product_id)
);

