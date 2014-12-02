class ChangePickedUpDefaultToFalse < ActiveRecord::Migration
  def self.up
    change_column :products, :picked_up, :boolean, :default => false
  end
  
  def self.down
    change_column :products, :picked_up, :boolean
  end
end
