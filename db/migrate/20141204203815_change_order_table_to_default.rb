class ChangeOrderTableToDefault < ActiveRecord::Migration
 def self.up
    change_table :orders do |t|
      t.change :items_total, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :tax, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :total_with_tax, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :delivery, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :delivery_with_tax, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :assembly, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :grand_total, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :deposit, :decimal, :precision => 20, :scale => 2, :default => 0.0
      t.change :balance_due, :decimal, :precision => 20, :scale => 2, :default => 0.0
    end
  end
  def self.down
    change_table :orders do |t|
      t.change :items_total, :decimal, :precision => 20, :scale => 2
      t.change :tax, :decimal, :precision => 20, :scale => 2
      t.change :total_with_tax, :decimal, :precision => 20, :scale => 2
      t.change :delivery, :decimal, :precision => 20, :scale => 2
      t.change :delivery_with_tax, :decimal, :precision => 20, :scale => 2
      t.change :assembly, :decimal, :precision => 20, :scale => 2
      t.change :grand_total, :decimal, :precision => 20, :scale => 2
      t.change :deposit, :decimal, :precision => 20, :scale => 2
      t.change :balance_due, :decimal, :precision => 20, :scale => 2
    end
  end
end
