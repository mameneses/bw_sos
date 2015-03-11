class OrdersController < ApplicationController

  def index
    if params[:date]
      @follow_ups = Order.where(follow_up_date: params[:date]).order(updated_at: :asc)
      @follow_up_date = params[:date]
    else  
      @follow_ups = Order.where(follow_up_date: Date.today).order(updated_at: :asc)
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
     location = @order.store_location
      sales_tax = 0.09
      if  location == "San Rafael"
        sales_tax = Settings.san_rafael_tax
      elsif location == "San Bruno"
        sales_tax = Settings.san_bruno_tax
      else location == "Oakland"
        sales_tax = Settings.oakland_tax
      end
    delivery_w_tax = @order.delivery * sales_tax + @order.delivery
    grand_total = @order.total_with_tax + delivery_w_tax + @order.assembly
    balance_due = grand_total - @order.deposit
    @order.update(grand_total: grand_total, balance_due: balance_due, delivery_with_tax: delivery_w_tax )
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
