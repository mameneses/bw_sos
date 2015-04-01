require 'spec_helper'
describe Order do
  it 'destroys dependent products when destroyed' do
    @order = Order.create
    product = Product.create(price:100)

    @order.products << product

    expect { @order.destroy }.to change {Product.count}.by(-1)
  end
end