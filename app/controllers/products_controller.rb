class ProductsController < ApplicationController
  
   def index
      @products = Product.order(created_at: :desc).first(15)
   end

   def show
      @product = Product.find(params[:id])
   end

   def new
      @product = Product.new
   end

   def create
      @product = Product.create(product_params)
      if product_order_id_params[:order_id]
         Order.find(product_order_id_params[:order_id].to_i).products << @product
         redirect_to "/orders/#{product_order_id_params[:order_id]}/edit"
      else
        redirect_to "/products"
      end
   end

   def edit
      @product = Product.find(params[:id])
   end
   
   def update
   end

   def destroy
      Product.find(params[:id]).destroy
      redirect_to "/orders/#{product_order_id_params[:order_id]}/edit"
   end
 
 private
   def product_params
     params.require(:product).permit(:company, :model_type, :description, :price)
   end

   def product_order_id_params
      params.require(:product).permit(:order_id)
   end

end
