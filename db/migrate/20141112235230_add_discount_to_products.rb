class AddDiscountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :discount, :decimal, :precision => 20, :scale => 2
  end
end
