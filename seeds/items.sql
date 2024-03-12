TRUNCATE TABLE items, orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO items (name, price, quantity) VALUES ('First item', 4.5, 23);
INSERT INTO items (name, price, quantity) VALUES ('Second item', 7.0, 31);
INSERT INTO items (name, price, quantity) VALUES ('Third item', 12.9, 11);
INSERT INTO items (name, price, quantity) VALUES ('Fourth item', 29.35, 5);

