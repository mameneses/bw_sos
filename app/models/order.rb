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
    self.assembly ||= 0
    self.grand_total ||= 0
    self.deposit ||= 0
    self.balance_due ||= 0
    self.items_total ||= 0
    self.complete = false if self.complete.nil?
  end

  def destroy_products
    self.products.each do |product|
      product.destroy
    end
  end
end
