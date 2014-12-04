class CustomersController < ApplicationController

  def index
    if params[:q]
      @customers = Customer.where("LOWER(first_name) LIKE LOWER(?)", "%#{params[:q]}%").concat(Customer.where("LOWER(last_name) LIKE LOWER(?)", "%#{params[:q]}%")).uniq
    else
      @customers = Customer.order(created_at: :desc).first(15)
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
    @order = Order.new
    @user = current_user
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    redirect_to "/customers/#{@customer.id}"
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to "/customers/#{params[:id]}"
  end

  def destroy
    @customer = Customer.find(params[:id]).destroy
    redirect_to "/customers"
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :city, :state, :zip_code, :phone_num, :alt_phone_num, :email)
  end
end
