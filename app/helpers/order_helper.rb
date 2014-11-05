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

  def to_cents(number)
    number.to_s.split("").insert(".",-2).join
  end
end
