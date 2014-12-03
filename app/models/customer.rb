class Customer < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :products
  before_create :capitalize_names, :style_phone_numbers

  private
    def capitalize_names
      self.first_name = self.first_name.capitalize
      self.last_name = self.last_name.capitalize
    end

    def style_phone_numbers
      if self.phone_num != "" 
        self.phone_num = self.phone_num.insert(0,"(").insert(4,")").insert(5," ").insert(9,"-")
      end
      if self.alt_phone_num != ""
        self.alt_phone_num = self.alt_phone_num.insert(0,"(").insert(4,")").insert(5," ").insert(9,"-")
      end
    end
end
