class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :placed_by
      t.date :placed_date
      t.date :follow_up_date
      t.integer :customer_id
      t.integer :product_id
      t.integer :items_total, default: "0" 
      t.integer :tax
      t.integer :total_with_tax
      t.integer :delivery
      t.integer :assembly
      t.integer :grand_total
      t.integer :deposit
      t.integer :balance_due
      t.text :notes
      t.string :purchased_by
      t.text :gift_note
      t.boolean :complete
      t.timestamps
    end
  end
end
