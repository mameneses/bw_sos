class RemoveReadyFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ready, :boolean, :default => false
  end
end
