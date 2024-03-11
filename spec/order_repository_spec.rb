require 'order_repository'

RSpec.describe OrderRepository do
  def reset_orders_table
    seed_sql = File.read('seeds/orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_orders_table
  end

  describe '#all' do
    it 'returns all orders' do
      repo = OrderRepository.new

      orders = repo.all

      expect(orders.length).to eq 6

      expect(orders[0].id).to eq 1
      expect(orders[0].customer_name).to eq 'First customer'
      expect(orders[0].date).to eq '2024-03-02'
      expect(orders[0].item_id).to eq 2

      expect(orders[1].id).to eq 2
      expect(orders[1].customer_name).to eq 'Second customer'
      expect(orders[1].date).to eq '2024-03-04'
      expect(orders[1].item_id).to eq 4

      expect(orders[2].id).to eq 3
      expect(orders[2].customer_name).to eq 'Third customer'
      expect(orders[2].date).to eq '2024-03-05'
      expect(orders[2].item_id).to eq 1

      expect(orders[3].id).to eq 4
      expect(orders[3].customer_name).to eq 'Fourth customer'
      expect(orders[3].date).to eq '2024-03-07'
      expect(orders[3].item_id).to eq 3

      expect(orders[4].id).to eq 5
      expect(orders[4].customer_name).to eq 'Fifth customer'
      expect(orders[4].date).to eq '2024-03-10'
      expect(orders[4].item_id).to eq 1

      expect(orders[5].id).to eq 6
      expect(orders[5].customer_name).to eq 'Sixth customer'
      expect(orders[5].date).to eq '2024-03-11'
      expect(orders[5].item_id).to eq 2
    end
  end
end