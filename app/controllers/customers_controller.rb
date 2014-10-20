class CustomersController < ApplicationController

  def index
    if params[:q]
      @customers = Customer.where(first_name: params[:q].capitalize).concat(Customer.where(last_name: params[:q].capitalize)).uniq
    else
      @customers = Customer.order(created_at: :desc).first(15)
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @orders = @customer.orders
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    redirect_to "/customers"
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
