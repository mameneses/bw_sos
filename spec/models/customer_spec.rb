
describe Customer do
  context "Dependencies" do
    it 'destroy: dependent orders' do
      customer = Customer.create
      order = Order.create
      customer.orders << order

      expect { customer.destroy }.to change {Order.count}.by(-1)
    end
  end

  before :each do
    @smith = Customer.create( first_name: 'John', last_name: 'Smith', email: 'jsmith@example.com')
    @tyler = Customer.create( first_name: 'Tim', last_name: 'Tyler', email: 'tjones@example.com')
    @johnson = Customer.create( first_name: 'Val', last_name: 'Johnson', email: 'jjohnson@example.com')
  end

  context "ActiveREcord queries" do

    it 'returns query results that match first or last name' do
      expect(Customer.query_search("J")).to eq [@smith,@johnson ]
    end

    it 'excludes query results that do not match first or last name' do
      expect(Customer.query_search("J")).not_to include @tyler
    end

    it 'returns recently created ordered by created at' do
      expect(Customer.recent_short_list).to eq [@johnson,@tyler,@smith]
    end
  end
end