class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  before_create :capitalize_names

  def self.query_search(name)
    where("LOWER(first_name) LIKE LOWER(?)", "%#{name}%").concat(Customer.where("LOWER(last_name) LIKE LOWER(?)", "%#{name}%")).uniq
  end

  def self.recent
    order(created_at: :desc).first(15)
  end

  private
    def capitalize_names
      if self.first_name
        self.first_name = self.first_name.capitalize
      end
      if self.last_name
        self.last_name = self.last_name.capitalize
      end
    end
end
