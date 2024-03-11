require_relative 'lib/item_repository'

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
    if response == '1'
      list_items
    elsif response == '2'
      create_item
    elsif response == '3'
      list_orders
    elsif response == '4'
      create_orders
    else
      fail 'Invalid input! Please enter one nmber from 1 - 4.'
    end
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

  def list_items
    @io.puts 'Here is a list of all shop items:'
      @item_repository.all.each do |record|
        @io.puts "##{record.id} #{record.name} - Unit price: £#{record.price} - Quantity: #{record.quantity}"
      end
  end

  def create_item
    @io.puts 'Please enter the item\'s name:'
    name = @io.gets.chomp
    @io.puts 'Please enter the item\'s price:'
    price = @io.gets.chomp
    @io.puts 'Please enter the item\'s quantity:'
    quantity = @io.gets.chomp
    @io.puts "You added a new item; #{name} that costs £#{price} with a quantity of #{quantity}!"
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