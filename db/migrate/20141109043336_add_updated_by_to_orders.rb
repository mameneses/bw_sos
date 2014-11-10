class AddUpdatedByToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :updated_by, :string
  end
end
