require 'spec_helper'
describe Product do
  it 'is invalid without a price' do
    product = Product.new
    expect(product).to be_invalid
  end

  it 'is valid with integer price' do
    product = Product.new(price:1)
    expect(product).to be_valid
  end

  it 'is valid with a decimal price' do
    product = Product.new(price:1.12)
    expect(product).to be_valid
  end

  it 'removes product price from order totals' do
    order = Order.create
    product = Product.create(price:1)
    order.products << product

    expect{product.remove_item_from_order}.to change {product.orders.first.items_total.to_f}.by(-1)
  end

  it 'adds product price to orders totals' do
    order = Order.create
    product = Product.create(price:1)
    order.products << product 

    expect{product.add_item_to_order}.to change {product.orders.first.items_total.to_f}.by(1)
  end

  it 'capitalizes company name' do
    product = Product.new(company:"sam", price:1)
    expect {product.capitalize_company}.to change {product.company}.to("Sam")
  end

end
