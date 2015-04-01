class OrdersController < ApplicationController

  def index
    if params[:date]
      @follow_ups = Order.follow_up_by_date(params[:date])
      @follow_up_date = params[:date]
    else  
      @follow_ups = Order.follow_up_today
    end
    @orders = Order.order(created_at: :desc)
    @pending_issues = Order.where(issue: true).order(updated_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @product = Product.new
    @products = @order.products.order(picked_up: :asc)
    @customer = @order.customer

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReceiptPdf.new(@customer, @order, @products)
        pdf.autoprint
        send_data pdf.render, filename: "#{@customer.first_name}_#{@customer.last_name}_Receipt_#{@order.placed_date}.pdf", type: 'applicaiton/pdf'
      end
    end
  end

  def new 
    @customer = Customer.find(params[:customer_id].to_i)
    @order = Order.new
    @product = Product.new
    @user = current_user
  end

  def create
    @order = Order.create(order_params)
    redirect_to "/orders/#{@order.id}/" 
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
    @order.update_totals
    if params[:follow_up_page]
      redirect_to "/orders"
    else
      redirect_to "/orders/#{params[:id]}"
    end
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to "/orders"
  end

private

  def order_params
    params.require(:order).permit(:placed_by, :placed_date, :follow_up_date, :customer_id, :items_total, :tax, :total_with_tax, :delivery, :assembly, :grand_total, :deposit, :balance_due, :notes, :purchased_by, :gift_note, :complete, :store_location, :updated_by, :delivery_with_tax, :issue)
  end

end
