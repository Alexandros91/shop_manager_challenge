TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO items (name, price, quantity) VALUES ('First item', 4.5, 23);
INSERT INTO items (name, price, quantity) VALUES ('Second item', 7.0, 31);
INSERT INTO items (name, price, quantity) VALUES ('Third item', 12.9, 11);
INSERT INTO items (name, price, quantity) VALUES ('Fourth item', 29.35, 5);

INSERT INTO orders (customer_name, date, item_id) VALUES ('First customer', '2024-03-02', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Second customer', '2024-03-04', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Third customer', '2024-03-05', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Fourth customer', '2024-03-07', 3);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Fifth customer', '2024-03-08', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sixth customer', '2024-03-11', 2);
