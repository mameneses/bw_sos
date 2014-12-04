class AddIssueToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :issue, :boolean, :default => false
  end
end
