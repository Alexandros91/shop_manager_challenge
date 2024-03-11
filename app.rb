class Application

  def initialize(database_name, io, item_repository, order_repository)
    @database_name = database_name
    @io = io
    @item_repository = item_repository
    @order_repository = order_repository
  end

  def run
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What would you like to do?'
    @io.puts '* 1 - List all items'
    @io.puts '* 2 - Create a new item'
    @io.puts '* 3 - List all orders'
    @io.puts '* 4 - Create a new order'
    @io.puts 'Please enter your choice:'
    response = @io.gets.chomp
    if response = 1
      @io.puts 'Here is a list of all shop items:'
      @item_repository.all.each do |record|
        @io.puts "##{record.id} #{record.name} - Unit price: £#{record.price} - Quantity: #{record.quantity}"
      end
    end
  end
end