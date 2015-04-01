
describe Order do
  it 'destroys dependent products when destroyed' do
    @order = Order.create
    product = Product.create(price:100)
    @order.products << product

    expect { @order.destroy }.to change {Product.count}.by(-1)
  end

  it 'calculates and updates delievry with tax' do
    @order = Order.create(delivery:100, store_location:"Oakland")

    expect {@order.update_totals}.to change {@order.delivery_with_tax}.by(109)
  end

  it 'calculates and updates grand total' do
    @order = Order.create(total_with_tax:100, delivery:100, assembly:100, store_location:"Oakland")

    expect {@order.update_totals}.to change {@order.grand_total}.by(309)
  end

  it 'calculates and updates balance due' do
    @order = Order.create(total_with_tax:100, delivery:100, assembly:100, store_location:"Oakland", deposit:300)

    expect {@order.update_totals}.to change {@order.balance_due}.by(9)
  end

  before :each do
    @today = Order.create(follow_up_date: Date.today)
    @tomorrow = Order.create( follow_up_date: Date.today.next_day)
    @today2 = Order.create( follow_up_date: Date.today)
  end

  it 'returns query results that match follow up date query' do
    expect(Order.follow_up_by_date(Date.today.next_day)).to eq [@tomorrow]
  end

  it 'excludes query results that do not match follow up date query' do
    expect(Order.follow_up_by_date(Date.today.next_day)).not_to include @today
  end

  it 'returns results that match follow up todays date' do
    expect(Order.follow_up_today).to eq [@today, @today2]
  end

  it 'excludes query results that do not match todays date' do
    expect(Order.follow_up_today).not_to include @tomorrow
  end
end