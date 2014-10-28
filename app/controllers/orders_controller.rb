class OrdersController < ApplicationController

  def index
    @orders = Order.order(created_at: :desc).first(15)
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def new 
    @customer = Customer.find(params[:customer_id].to_i)
    @order = Order.new
    @product = Product.new
    @user = User.find(1)
  end

  def create
    @order = Order.create(order_params)
    redirect_to "/orders/#{@order.id}/edit" 
  end

  def edit
    @order = Order.find(params[:id])
    @products = @order.products(:all)
    @product = Product.new
    @customer = @order.customer
    @user = current_user
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    g_total = @order.total_with_tax + @order.delivery + @order.assembly
    b_due = g_total - @order.deposit
    @order.update(grand_total: g_total, balance_due: b_due )
    redirect_to "/orders/#{params[:id]}"
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to "/orders"
  end

private

  def order_params
    params.require(:order).permit(:placed_by, :placed_date, :follow_up_date, :customer_id, :items_total, :tax, :total_with_tax, :delivery, :assembly, :grand_total, :deposit, :balance_due, :notes, :purchased_by, :gift_note, :complete)
  end

end
