module ProductHelper
  def format_price (number)
    if number.to_s.size >= 2
      number.to_s.insert(-3,".")
    else
      number
    end
  end
end
