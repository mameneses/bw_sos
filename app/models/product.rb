class Product < ActiveRecord::Base
  has_and_belongs_to_many :orders
  validates :price, presence: true
  before_create :capitalize_company
  before_destroy :remove_item_from_order
  after_initialize :init

  def init
    self.discount ||= 0
    self.picked_up ||= false
  end

  def remove_item_from_order
    if self.orders.length > 0
      @order = self.orders.first
      remove_item
      set_tax
      update_order
    end
  end

  def add_item_to_order
    @order = self.orders.first
    add_item
    set_tax
    update_order
  end

  def capitalize_company
    if self.company
      self.company = self.company.capitalize
    end
  end

  private

  def set_tax
    location = @order.store_location
    sales_tax = 0.09
   if location == "San Rafael"
      sales_tax = Settings.san_rafael_tax
    elsif location == "San Bruno"
      sales_tax = Settings.san_bruno_tax
    else location == "Oakland"
      sales_tax = Settings.oakland_tax
    end
    @tax = @total * sales_tax.to_f
  end

  def add_item
    @total = @order.items_total + (self.price - (self.price * self.discount))
  end

  def remove_item
    @total = @order.items_total - (self.price - (self.price * self.discount))
  end

  def update_order
    total_w_tax = @total + @tax
    grand_total = total_w_tax + @order.delivery_with_tax + @order.assembly
    balance_due = grand_total - @order.deposit
    @order.update(items_total: @total, tax: @tax, total_with_tax: total_w_tax, grand_total: grand_total, balance_due: balance_due)
  end

end
