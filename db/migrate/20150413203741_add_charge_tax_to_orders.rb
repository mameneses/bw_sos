class AddChargeTaxToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :charge_tax, :boolean, :default => true
  end
end
