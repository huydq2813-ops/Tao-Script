CREATE SCHEMA IF NOT EXISTS core;
CREATE TABLE IF NOT EXISTS core.products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price NUMERIC(12,2) NOT NULL,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS core.users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS core.orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount NUMERIC(12,2) DEFAULT 0,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS core.order_items (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price NUMERIC(12,2) NOT NULL
);
ALTER TABLE core.orders
    ADD CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id) REFERENCES core.users(id);

ALTER TABLE core.order_items
    ADD CONSTRAINT fk_items_order
    FOREIGN KEY (order_id) REFERENCES core.orders(id);

ALTER TABLE core.order_items
    ADD CONSTRAINT fk_items_product
    FOREIGN KEY (product_id) REFERENCES core.products(id);

CREATE INDEX idx_users_email ON core.users(email);
CREATE INDEX idx_orders_user ON core.orders(user_id);
CREATE INDEX idx_items_order ON core.order_items(order_id);
CREATE INDEX idx_items_product ON core.order_items(product_id);
INSERT INTO core.users (full_name, email, password_hash)
VALUES 
('Admin User', 'dhuy7330@gmail.com', 'hash123');

INSERT INTO core.products (name, price, stock)
VALUES
('Iphone 15', 25000000, 10),
('Macbook Pro', 52000000, 5),
('Car', 50000000, 2);
