class Product < ActiveRecord::Base
  has_and_belongs_to_many :customers
  has_and_belongs_to_many :orders
  validates :price, presence: true
  before_destroy :update_order_remove_item

  def update_order_remove_item
    if self.orders.length > 0
      @order = self.orders.first
      total = @order.items_total - self.price
      tax = total * TAX
      total_w_tax = total + tax
      g_total = total_w_tax + @order.delivery + @order.assembly
      b_due = g_total - @order.deposit
      @order.update(items_total: total, tax: tax, total_with_tax: total_w_tax, grand_total: g_total, balance_due: b_due)
    end
  end

end
