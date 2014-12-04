class AddPickupOrDeliveryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pickup_or_delivery, :string, :default => "Pickup"
  end
end
