class AddPickUpDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pick_up_date, :date, :null => true
  end
end
