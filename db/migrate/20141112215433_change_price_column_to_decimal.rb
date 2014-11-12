class ChangePriceColumnToDecimal < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :decimal, :precision => 20, :scale => 2
  end

  def self.down
    change_column :products, :price, :integer
  end
end
