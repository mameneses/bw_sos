
describe Order do
  context "Dependencies" do
    it 'destroy: dependent products' do
      @order = Order.create
      product = Product.create(price:100)
      @order.products << product

      expect { @order.destroy }.to change {Product.count}.by(-1)
    end
  end
  context "Calculate and Update values" do
    it 'delievry with tax' do
      @order = Order.create(delivery:100, store_location:"Oakland")

      expect {@order.update_totals}.to change {@order.delivery_with_tax}.by(109)
    end

    it 'grand total' do
      @order = Order.create(items_total:100, delivery:100, assembly:100, store_location:"Oakland", charge_tax:true)

      expect {@order.update_totals}.to change {@order.grand_total}.by(318)
    end

    it 'balance due' do
      @order = Order.create(items_total:100, delivery:100, assembly:100, store_location:"Oakland", deposit:300, charge_tax:true)

      expect {@order.update_totals}.to change {@order.balance_due}.by(18)
    end
  end
  before :each do
    @today = Order.create(follow_up_date: Date.today)
    @tomorrow = Order.create( follow_up_date: Date.today.next_day, issue: true)
    @today2 = Order.create( follow_up_date: Date.today, issue: true)
  end
  context "ActiveRecord queries" do
    it 'returns results that match follow up date query' do
      expect(Order.follow_up_by_date(Date.today.next_day)).to eq [@tomorrow]
    end

    it 'excludes results that do not match follow up date query' do
      expect(Order.follow_up_by_date(Date.today.next_day)).not_to include @today
    end

    it 'returns results that match follow up todays date' do
      expect(Order.follow_up_today).to eq [@today, @today2]
    end

    it 'excludes results that do not match todays date' do
      expect(Order.follow_up_today).not_to include @tomorrow
    end

    it 'returns results with issues in descending order' do
      expect(Order.issues).to eq [@today2, @tomorrow ]
    end

     it 'excludes results without issues' do
      expect(Order.issues).not_to include @today
    end
  end
end