require 'spec_helper'
describe Customer do
  it 'destroys dependent orders when destroyed' do
    customer = Customer.create
    order = Order.create

    customer.orders << order

    expect { customer.destroy }.to change {Order.count}.by(-1)
  end

  before :each do
    @smith = Customer.create( first_name: 'John', last_name: 'Smith', email: 'jsmith@example.com')
    @tyler = Customer.create( first_name: 'Tim', last_name: 'Tyler', email: 'tjones@example.com')
    @johnson = Customer.create( first_name: 'Val', last_name: 'Johnson', email: 'jjohnson@example.com')
  end

  it 'returns query results that match' do
    expect(Customer.query_search("J")).to eq [@smith,@johnson ]
  end

  it 'excludes query results that do not match' do
    expect(Customer.query_search("J")).not_to include @tyler
  end

  it 'returns recently create' do

  end
end