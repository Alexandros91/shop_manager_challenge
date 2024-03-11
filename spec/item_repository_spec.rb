require 'item_repository'

RSpec.describe ItemRepository do

  def reset_items_table
    seed_sql = File.read('seeds/orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_items_table
  end

  describe '#all' do
    it 'returns a list of items' do
      repo = ItemRepository.new

      items = repo.all

      expect(items.length).to eq 4

      expect(items[0].id).to eq 1
      expect(items[0].name).to eq 'First item'
      expect(items[0].price).to eq 4.5
      expect(items[0].quantity).to eq 23

      expect(items[1].id).to eq 2
      expect(items[1].name).to eq 'Second item'
      expect(items[1].price).to eq 7.0
      expect(items[1].quantity).to eq 31

      expect(items[2].id).to eq 3
      expect(items[2].name).to eq 'Third item'
      expect(items[2].price).to eq 12.9
      expect(items[2].quantity).to eq 11

      expect(items[3].id).to eq 4
      expect(items[3].name).to eq 'Fourth item'
      expect(items[3].price).to eq 29.35
      expect(items[3].quantity).to eq 5
    end
  end
end