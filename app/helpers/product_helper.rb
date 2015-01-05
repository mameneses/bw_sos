module ProductHelper
  def format_price (number)
    if number.to_s.size >= 2 
      number.to_s.insert(-3,".")
    elsif number.to_s.size >= 5
      number.to_s.insert(-3,".").insert(-5,",")
    else
      number
    end
  end

  def format_discount (decimal)
    if decimal == 0 || decimal == nil
      "None"
    else
      number_to_percentage((decimal * 100), precision: 0)
    end
  end
end
