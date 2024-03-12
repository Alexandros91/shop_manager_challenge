require_relative 'lib/item_repository'
require_relative 'lib/item'
require_relative 'lib/order_repository'
require_relative 'lib/database_connection'

class Application

  def initialize(database_name, io, item_repository, order_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    intro_messages
    response = @io.gets.chomp
    options_menu(response)
  end

  private

  def intro_messages
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What would you like to do?'
    @io.puts '* 1 - List all items'
    @io.puts '* 2 - Create a new item'
    @io.puts '* 3 - List all orders'
    @io.puts '* 4 - Create a new order'
    @io.puts 'Please enter your choice:'
  end

  def options_menu(response)
    case response
    when '1'
      list_items
    when '2' 
      create_item
    when '3' 
      list_orders
    when '4'
      create_orders
    else
      fail 'Invalid input! Please enter one nmber from 1 - 4.'
    end
  end

  def list_items
    @io.puts 'Here is a list of all shop items:'
    @item_repository.all.each do |record|
      @io.puts "##{record.id} #{record.name} - Unit price: £#{record.price} - Quantity: #{record.quantity}"
    end
  end

  def create_item
    @io.puts 'Please enter the item\'s name:'
    item_name = @io.gets.chomp
    @io.puts 'Please enter the item\'s price:'
    item_price = @io.gets.chomp
    @io.puts 'Please enter the item\'s quantity:'
    item_quantity = @io.gets.chomp
    @io.puts "You added a new item; #{item_name} that costs £#{item_price} with a quantity of #{item_quantity}!"
    new_item = Item.new
    new_item.name = item_name
    new_item.price = item_price.to_f
    new_item.quantity = item_quantity.to_i
    @item_repository.create(new_item)
  end

  def list_orders
    @io.puts 'Here is a list of all orders:'
    @order_repository.all.each do |record|
      @io.puts "##{record.id} #{record.customer_name} - Date of Order: #{record.date} with item id: #{record.item_id}"
    end
  end

  def create_orders
    @io.puts 'Please enter the customer\'s name:'
    customer_name = @io.gets.chomp
    @io.puts 'Please enter the order\'s date:'
    date = @io.gets.chomp
    @io.puts 'Please enter the item\'s id:'
    item_id = @io.gets.chomp
    @io.puts "You added a new order for #{customer_name} on #{date} that includes the item with id #{item_id}!"
    new_order = Order.new
    new_order.customer_name = customer_name
    new_order.date = date
    new_order.item_id = item_id.to_i
    @order_repository.create(new_order)
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new
  )
  app.run
end
