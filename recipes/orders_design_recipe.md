# ORDERS Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `orders`*

```
# EXAMPLE

Table: orders

Columns:
id | customer_name | date | order_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in ordergreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: seeds/orders.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE orders RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO orders (customer_name, date, order_id) VALUES ('First customer', 2024-03-02, 2);
INSERT INTO orders (customer_name, date, order_id) VALUES ('Second customer', 2024-03-04, 4);
INSERT INTO orders (customer_name, date, order_id) VALUES ('Third customer', 2024-03-05, 1);
INSERT INTO orders (customer_name, date, order_id) VALUES ('Fourth customer', 2024-03-07, 3);
INSERT INTO orders (customer_name, date, order_id) VALUES ('Fifth customer', 2024-03-08, 1);
INSERT INTO orders (customer_name, date, order_id) VALUES ('Sixth customer', 2024-03-11, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 shop_manager < seeds/orders.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)
class Order
end

# Repoordersitory class
# (in lib/order_repository.rb)
class OrderRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: orders

# Model class
# (in lib/order.rb)

class Order

  # Replace the attributes by your own columns.
  attr_accessor :id, :customer_name, :date, :item_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# order = order.new
# order.name = 'Jo'
# order.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: orders

# Repository class
# (in lib/orders_repository.rb)

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders;

    # Returns an array of order objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, customer_name, date, item_id FROM orders WHERE id = $1;

    # Returns a single order object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(order)
  # end

  # def update(order)
  # end

  # def delete(id)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all orders

repo = orderRepository.new

orders = repo.all

orders.length # =>  6

orders[0].id # =>  1
orders[0].name # =>  'First customer'
orders[0].date # => 2024-03-02
orders[0].item_id # =>  2

orders[1].id # =>  2
orders[1].name # =>  'Second customer'
orders[1].date # =>  2024-03-04
orders[1].item_id # =>  4

orders[2].id # =>  3
orders[2].name # =>  'Third customer'
orders[2].date # =>  2024-03-05
orders[2].item_id # =>  1

orders[3].id # =>  4
orders[3].name # =>  'Fourth customer'
orders[3].date # =>  2024-03-07
orders[3].item_id # =>  3

orders[4].id # =>  5
orders[4].name # =>  'Fifth customer'
orders[4].date # =>  2024-03-08
orders[4].item_id # =>  1

orders[5].id # =>  6
orders[5].name # =>  'Sixth customer'
orders[5].date # =>  2024-03-11
orders[5].item_id # =>  2

# 2
# Get a single order

repo = orderRepository.new

order = repo.find(1)

order.id # =>  1
order.name # =>  'First customer'
order.date # =>  2024-03-02
order.item_id # =>  2

order = repo.find(2)

order.id # =>  2
order.name # =>  'Second customer'
order.date # =>  2024-03-04
order.item_id # =>  4

order = repo.find(3)

order.id # =>  3
order.name # =>  'Third customer'
order.date # =>  122024-03-05
order.item_id # =>  1

order = repo.find(4)

order.id # =>  4
order.name # =>  'Fourth customer'
order.date # =>  2024-03-07
order.item_id # =>  3

order = repo.find(5)

order.id # =>  5
order.name # =>  'Fifth customer'
order.date # =>  2024-03-08
order.item_id # =>  1

order = repo.find(6)

order.id # =>  6
order.name # =>  'Sixth customer'
order.date # =>  2024-03-11
order.item_id # =>  2

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table dates every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/order_repository_spec.rb

# describe orderRepository do
  def reset_orders_table
    seed_sql = File.read('seeds/orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

    # (your tests will go here).
# end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->