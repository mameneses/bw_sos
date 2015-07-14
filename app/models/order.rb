class Order < ActiveRecord::Base
  belongs_to :customer
  has_and_belongs_to_many :products
  after_initialize :init
  before_destroy :destroy_products

  def init
    self.items_total ||= 0
    self.tax ||= 0
    self.total_with_tax ||= 0
    self.delivery ||= 0
    self.delivery_with_tax ||= 0
    self.assembly ||= 0
    self.grand_total ||= 0
    self.deposit ||= 0
    self.balance_due ||= 0
    self.items_total ||= 0
    self.complete = false if self.complete.nil?
    self.charge_tax ||=true if self.charge_tax.nil?
  end

  def destroy_products
    self.products.each do |product|
      product.destroy
    end
  end

  def self.follow_up_today
    where(follow_up_date: Date.today).order(updated_at: :asc)
  end

  def self.follow_up_by_date(date)
    where(follow_up_date: date).order(updated_at: :asc)
  end
  
  def self.issues
    where(issue: true).order(updated_at: :desc)
  end
  
  def update_totals
    location = self.store_location
    sales_tax = 0.09
    if  location == "San Rafael"
      sales_tax = Settings.san_rafael_tax
    elsif location == "San Bruno"
      sales_tax = Settings.san_bruno_tax
    else location == "Oakland"
      sales_tax = Settings.oakland_tax
    end
    if !self.charge_tax
      total_sales_tax = 0
    else
      total_sales_tax = sales_tax
    end
    tax = (self.items_total * total_sales_tax).round(2)
    total_with_tax = self.items_total + tax
    delivery_w_tax = (self.delivery * sales_tax).round(2) + self.delivery
    grand_total = total_with_tax + delivery_w_tax + self.assembly
    balance_due = grand_total - self.deposit
    self.update(tax: tax, total_with_tax: total_with_tax, grand_total: grand_total, balance_due: balance_due, delivery_with_tax: delivery_w_tax )
  end
end
