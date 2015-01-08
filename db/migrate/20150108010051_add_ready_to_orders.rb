class AddReadyToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ready, :boolean, :default => false
  end
end
