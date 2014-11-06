class AddStoreLocationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :store_location, :string
  end
end
