class AddReadyToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ready, :boolean, :default => false
  end
end
