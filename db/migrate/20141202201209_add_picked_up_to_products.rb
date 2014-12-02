class AddPickedUpToProducts < ActiveRecord::Migration
  def change
    add_column :products, :picked_up, :boolean
  end
end
