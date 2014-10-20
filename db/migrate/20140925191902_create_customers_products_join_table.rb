class CreateCustomersProductsJoinTable < ActiveRecord::Migration
  def change
    create_table :customers_products, id: false do |t|
      t.integer :customer_id
      t.integer :product_id
    end
  end
end
