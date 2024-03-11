# Shop Manager Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a shop manager
So I can know which items I have in stock
I want to keep a list of my shop items with their name and unit price.

As a shop manager
So I can know which items I have in stock
I want to know which quantity (a number) I have for each item.

As a shop manager
So I can manage items
I want to be able to create a new item.

As a shop manager
So I can know which orders were made
I want to keep a list of orders with their customer name.

As a shop manager
So I can know which orders were made
I want to assign each order to their corresponding item.

As a shop manager
So I can know which orders were made
I want to know on which date an order was placed. 

As a shop manager
So I can manage orders
I want to be able to create a new order.

```
```
Nouns:

items, item_name, item_price, item_quantity, orders, order_customer_name, order_item, order_date
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| items                 | name, price, quantity
| orders                | customer_name, date, (item)

1. Name of the first table (always plural): `items` 

    Column names: `name`, `price`, `quantity`

2. Name of the second table (always plural): `orders` 

    Column names: `customer_name`, `date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: items
id: SERIAL
name: text
price: numeric
quantity: int


Table: orders
id: SERIAL
customer_name: text
date: date
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one ITEM have many ORDERS? YES
2. Can one ORDER have many ITEMS? NO

You'll then be able to say that:

1. **ITEM has many ORDERS**
2. And on the other side, **ORDER belongs to ITEM**
3. In that case, the foreign key is in the table ORDERS.

Replace the relevant bits in this example with your own:


## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: shop_manager.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name text,
  price numeric,
  quantity int
);

-- Then the table with the foreign key first.
-- The foreign key name is always {other_table_singular}_id
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_name text,
  date date,
  item_id int,
  constraint fk_item foreign key(item_id)
    references items(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 shop_manager < shop_manager.sql
```