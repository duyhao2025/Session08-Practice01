CREATE DATABASE order_management;

\c order_management;

CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

INSERT INTO order_detail (order_id, product_name, quantity, unit_price)
VALUES
(1, 'Laptop', 2, 15000000),
(1, 'Mouse', 1, 300000),
(1, 'Keyboard', 1, 700000),
(2, 'Monitor', 2, 4000000),
(2, 'Headphone', 1, 1200000);

CREATE OR REPLACE PROCEDURE calculate_order_total(
    IN order_id_input INT,
    INOUT total NUMERIC DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;
END;
$$;

CALL calculate_order_total(1, 0);

CALL calculate_order_total(2, 0);