require_relative '../app'

RSpec.describe Application do
  describe '#run' do
    context 'when choosing 1' do
      it 'lists all items' do
        item_repository = double :item_repository
        order_repository = double :order_repository
        allow(item_repository).to receive(:all).and_return([
          double(id: 1, name: 'Item 1', price: 3.00, quantity: 3),
          double(id: 2, name: 'Item 2', price: 6.00, quantity: 2),
          double(id: 3, name: 'Item 3', price: 9.00, quantity: 1),
        ])
        io = double :io
        expect(io).to receive(:puts).and_return('Welcome to the shop management program!')
        expect(io).to receive(:puts).and_return('What would you like to do?')
        expect(io).to receive(:puts).and_return('* 1 - List all items')
        expect(io).to receive(:puts).and_return('* 2 - Create a new item')
        expect(io).to receive(:puts).and_return('* 3 - List all orders')
        expect(io).to receive(:puts).and_return('* 4 - Create a new order')
        expect(io).to receive(:puts).and_return('Please enter your choice:')
        expect(io).to receive(:gets).and_return('1')
        expect(io).to receive(:puts).and_return('Here is a list of all shop items:')
        expect(io).to receive(:puts).and_return('#1 Item 1 - Unit price: £3.00 - Quantity: 3')
        expect(io).to receive(:puts).and_return('#2 Item 2 - Unit price: £6.00 - Quantity: 2')
        expect(io).to receive(:puts).and_return('#3 Item 3 - Unit price: £9.00 - Quantity: 1')
        app = Application.new('shop_manager', io, item_repository, order_repository)
        app.run
      end
    end
  end
end