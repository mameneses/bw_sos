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

  def discount_options ()
    discount_options =   [["None",0.0],
                          ["5%",0.05],
                          ["10%",0.1],
                          ["15%",0.15],
                          ["20%",0.2],
                          ["25%",0.25],
                          ["30%",0.3],
                          ["35%",0.35],
                          ["40%",0.4],
                          ["45%",0.45],
                          ["50%",0.5],
                          ["55%",0.55],
                          ["60%",0.6],
                          ["65%",0.65],
                          ["70%",0.75],
                          ["80%",0.8],
                          ["85%",0.85],
                          ["100%",0.1],
                         ]
    return discount_options                     
  end

  def format_discount (decimal)
    if decimal == 0 || decimal == nil
      "None"
    else
      number_to_percentage((decimal * 100), precision: 0)
    end
  end
end
