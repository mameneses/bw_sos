class ProductsController < ApplicationController
  def index
    if params[:date]
      @pick_up_products = Product.where(pick_up_date: params[:date]).order(updated_at: :asc)
      @pick_up_date = params[:date]
    else  
      @pick_up_products = Product.where(pick_up_date: Date.today).order(updated_at: :asc)
    end

    if params[:q]
      query = params[:q]
      @products = Product.where("LOWER(company) LIKE LOWER(?)", "%#{query}%").order(created_at: :desc).concat(Product.where("LOWER(model_type) LIKE LOWER(?)", "%#{query}%")).concat(Product.where("LOWER(description) LIKE LOWER(?)", "%#{query}%")).uniq
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
      redirect_to "/orders/#{product_order_id_params[:order_id]}"
    else
      @order.update(updated_by:"#{current_user.first_name}")
      @order.products << @product
      @product.add_item_to_order
      redirect_to "/orders/#{product_order_id_params[:order_id]}"
    end
  end  

  def edit
    @product = Product.find(params[:id])
    @order = @product.orders.first
  end
   
  def update
    @product = Product.find(params[:id])
    @order = Order.find(product_order_id_params[:order_id].to_i)
    @order.update(updated_at: Time.now)
    @product.update(product_params)
    if params[:products_index]
      redirect_to "/products"
    else
      redirect_to "/orders/#{product_order_id_params[:order_id]}"
    end
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
    params.require(:product).permit(:company, :model_type, :description, :price, :discount, :picked_up, :pick_up_date, :pickup_or_delivery, :ready)
  end

  def product_order_id_params
    params.require(:product).permit(:order_id)
  end

  def product_products_index_params
    params.require(:product).permit(:products_index)
  end

end
