class AddCustomerNotesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :customer_notes, :text
  end
end
