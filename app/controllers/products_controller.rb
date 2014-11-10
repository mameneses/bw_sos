class ProductsController < ApplicationController
  
   def index
      if params[:q]
      query = params[:q]
      @products = Product.where("LOWER(company) LIKE LOWER(?)", "%#{query}%").order(created_at: :desc).concat(Product.where("LOWER(model_type) LIKE LOWER(?)", "%#{query}%")).uniq
      else
      @products = Product.order(created_at: :desc).first(15)
      end
   end

   def show
      @product = Product.find(params[:id])
   end

   def new
      @product = Product.new
   end

  def create
      @order = Order.find(product_order_id_params[:order_id].to_i)
      @product = Product.create(product_params)
    if @product.valid? == false
      redirect_to "/orders/#{product_order_id_params[:order_id]}/edit"
    else
      @order.update(updated_by:"#{current_user.first_name}")
      @product.errors.clear
      @order.products << @product
      @order = @product.orders.first
      total = @order.items_total + @product.price
      sales_tax = 0.09
      if  location == "San Rafael"
        sales_tax = Settings.tax.san_rafael
      elsif location == "San Bruno"
        sales_tax = Settings.tax.san_bruno
      else location == "Oakland"
        sales_tax = Settings.tax.oakland
      end
      tax = total * sales_tax
      total_w_tax = total + tax
      g_total = total_w_tax + @order.delivery + @order.assembly
      b_due = g_total - @order.deposit
      @order.update(items_total: total, tax: tax, total_with_tax: total_w_tax, grand_total: g_total, balance_due: b_due)
      redirect_to "/orders/#{product_order_id_params[:order_id]}"
    end
  end  

   def edit
      @product = Product.find(params[:id])
   end
   
   def update
   end

   def destroy
      @product = Product.find(params[:id])
      @order = @product.orders.first
      @order.update(updated_by:"#{current_user.first_name}")
        @product.destroy
        redirect_to "/orders/#{product_order_id_params[:order_id]}"
   end
 
 private
   def product_params
     params.require(:product).permit(:company, :model_type, :description, :price)
   end

   def product_order_id_params
      params.require(:product).permit(:order_id)
   end

end
