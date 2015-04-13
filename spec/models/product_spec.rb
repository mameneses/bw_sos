
describe Product do
  context "Price input" do
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
  end

  context "Before create" do
    it 'capitalizes company name' do
      product = Product.new(company:"sam", price:1)
      expect {product.capitalize_company}.to change {product.company}.to("Sam")
    end
  end

  context "Calculates and updates Order values when Product added" do
    
    it 'total with tax' do
      order = Order.create
      product = Product.create(price:100)
      order.products << product 

      expect{product.add_item_to_order}.to change {product.orders.first.total_with_tax}.by(109)
    end

    it 'grand total' do
      order = Order.create(delivery_with_tax:100,assembly:100)
      product = Product.create(price:100)
      order.products << product 

      expect{product.add_item_to_order}.to change {product.orders.first.grand_total}.by(309)
    end

    it 'balance due' do
      order = Order.create(delivery_with_tax:100,assembly:100, deposit:100)
      product = Product.create(price:100)
      order.products << product 

      expect{product.add_item_to_order}.to change {product.orders.first.balance_due}.by(209)
    end

     it 'product price to orders totals' do
      order = Order.create
      product = Product.create(price:1)
      order.products << product 

      expect{product.add_item_to_order}.to change {product.orders.first.items_total}.by(1)
    end
  end
  context "Calculates and updates Order values when Product removed" do
    it 'item totals' do
      order = Order.create
      product = Product.create(price:1)
      order.products << product

      expect{product.remove_item_from_order}.to change {product.orders.first.items_total}.by(-1)
    end

    it 'total with tax' do
      order = Order.create
      product = Product.create(price:100)
      order.products << product 

      expect{product.remove_item_from_order}.to change {product.orders.first.total_with_tax}.by(-109)
    end

    it 'grand total ' do
      order = Order.create(delivery_with_tax:100,assembly:100)
      product = Product.create(price:100)
      order.products << product 
      product.add_item_to_order
      expect{product.remove_item_from_order}.to change {product.orders.first.grand_total}.by(-109)
    end

    it 'balance due' do
      order = Order.create(delivery_with_tax:100,assembly:100, deposit:100)
      product = Product.create(price:100)
      order.products << product 
      product.add_item_to_order
      expect{product.remove_item_from_order}.to change {product.orders.first.balance_due}.by(-109)
    end
  end

   before :each do
    @smith = Product.create( company: 'John', model_type: 'Smith', description: 'Blue', price:100)
    @tyler = Product.create( company: 'Tim', model_type: 'Tyler', description: 'Red', price:50)
    @johnson = Product.create( company: 'Val', model_type: 'Johnson', description: 'Green', price:10)
  end

  context "ActiveRecord queries" do
    it 'returns results that match company name and model name' do
      expect(Product.query_search("J")).to eq [@smith,@johnson ]
    end

    it 'excludes results that do not match company name or model name' do
      expect(Product.query_search("J")).not_to include @tyler
    end

    it 'returns results that match description' do
      expect(Product.query_search("Red")).to eq [@tyler]
    end

    it 'excludes results that do not match description' do
      expect(Product.query_search("R")).not_to include @smith 
    end
  end

end
