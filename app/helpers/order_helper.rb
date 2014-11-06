module OrderHelper
  # TAX = 0.0575
  def order_total(products)
    @order_total = 0
    products.each do |product|
      @order_total += product.price
    end
    @order_total
  end

  def grand_total(order, products)
    order_total(products) + order.delivery + order.assembly
  end

  def balance_due (order, products, deposit)
    grand_total(order,products) - deposit
  end

  def tax (products)
    order_total(products) * TAX
  end

  def total_w_tax(products)
    order_total(products) + tax(products)
  end

  def format_price (number)
    if number.to_s.size >= 2
      number.to_s.insert(-3,".")
    elsif number.to_s.size >= 6
      number.to_s.insert(-3,".").insert(-7,",")
    else
      number
    end
  end
end
