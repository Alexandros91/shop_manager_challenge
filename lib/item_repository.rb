require_relative './item'

class ItemRepository
  
  def all
    sql = 'SELECT id, name, price, quantity FROM items;'

    result_set = DatabaseConnection.exec_params(sql, [])

    items = []
    
    result_set.each do |record|
      record_to_item_object(record)
      items << record_to_item_object(record)
    end

    return items
  end

  def create(item)
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  private

  def record_to_item_object(record)
    item = Item.new
    item.id = record['id'].to_i
    item.name = record['name']
    item.price = record['price'].to_f
    item.quantity = record['quantity'].to_i

    return item
  end
end
