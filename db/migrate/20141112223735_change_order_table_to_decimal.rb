class ChangeOrderTableToDecimal < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.change :items_total, :decimal, :precision => 20, :scale => 2
      t.change :tax, :decimal, :precision => 20, :scale => 2
      t.change :total_with_tax, :decimal, :precision => 20, :scale => 2
      t.change :delivery, :decimal, :precision => 20, :scale => 2
      t.change :assembly, :decimal, :precision => 20, :scale => 2
      t.change :grand_total, :decimal, :precision => 20, :scale => 2
      t.change :deposit, :decimal, :precision => 20, :scale => 2
      t.change :balance_due, :decimal, :precision => 20, :scale => 2
    end
  end

    def self.dow 
    change_table :orders do |t|
      t.change :items_total, :integer
      t.change :tax, :integer
      t.change :total_with_tax, :integer
      t.change :delivery, :integer
      t.change :assembly, :integer
      t.change :grand_total, :integer
      t.change :deposit, :integer
      t.change :balance_due, :integer
    end
  end
end
