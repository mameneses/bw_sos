class AddDeliveryWithTaxToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_with_tax, :decimal, :precision => 20, :scale => 2
  end
end
