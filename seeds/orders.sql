TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, item_id) VALUES ('First customer', '2024-03-02', 2);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Second customer', '2024-03-04', 4);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Third customer', '2024-03-05', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Fourth customer', '2024-03-07', 3);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Fifth customer', '2024-03-10', 1);
INSERT INTO orders (customer_name, date, item_id) VALUES ('Sixth customer', '2024-03-11', 2);
