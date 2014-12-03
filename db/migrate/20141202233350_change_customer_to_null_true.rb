class ChangeCustomerToNullTrue < ActiveRecord::Migration
  def self.up
    change_table :customers do |t|
      t.change :address, :string, :null => true
      t.change :city, :string, :null => true
      t.change :state, :string, :null => true
      t.change :zip_code, :string, :null => true
      t.change :phone_num, :string, :null => true
      t.change :alt_phone_num, :string, :null => true
      t.change :email, :string, :null => true
    end
  end
  
  def self.down
    change_table :customers do |t|
      t.change :address, :string
      t.change :city, :string
      t.change :state, :string
      t.change :zip_code, :string
      t.change :phone_num, :string
      t.change :alt_phone_num, :string
      t.change :email, :string
    end
  end
end
