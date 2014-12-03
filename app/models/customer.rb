class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :products
  before_create :capitalize_names

  private
    def capitalize_names
      self.first_name = self.first_name.capitalize
      self.last_name = self.last_name.capitalize
    end
end
