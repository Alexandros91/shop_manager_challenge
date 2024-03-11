require_relative './order'

class OrderRepository

  def all
    sql = 'SELECT id, customer_name, date, item_id FROM orders;'

    result_set = DatabaseConnection.exec_params(sql, [])

    orders =[]

    result_set.each do |record|
      order = Order.new
      order.id = record['id'].to_i
      order.customer_name = record['customer_name']
      order.date = record['date']
      order.item_id = record['item_id'].to_i

      orders << order
    end

    return orders
  end
end