require 'prawn/table'

class ReceiptPdf < Prawn::Document
  def initialize(customer, order, products)
    super()
    @customer = customer
    @order = order
    @products = products
    header
    table_content
    text_content
  end

  def price_format number
    number = number.to_s
    if number.size >= 2
      number.insert(-3,".")
    elsif number.size >= 6
      number.insert(-3,".").insert(-7,",")
    else
      number  
    end    
  end
 
  def header
    if @order.store_location == "Oakland"
      text "Baby World", size: 15, style: :bold
      text "4400 Telegraph Ave", size: 10
      text "Oakland, CA 94609", size: 10
      text "(510) 282-4406", size: 10
      text "http://www.babyworldonline.net", size: 10
      text "luz@babyworldonline.net", size: 10
    elsif @order.store_location == "San Bruno"
      text "Baby World", size: 15, style: :bold
      text "556 San Mateo Ave", size: 10
      text "San Bruno, CA 94066", size: 10
      text "(650) 588-7644", size: 10
      text "http://www.babyworldonline.net", size: 10
      text "luz@babyworldonline.net", size: 10
    elsif @order.store_location == "San Rafael"
      text "Baby World", size: 15, style: :bold
      text "514 4th St", size: 10
      text "San Rafael, CA 94901", size: 10
      text "(415) 456-5533", size: 10
      text "http://www.babyworldonline.net", size: 10
      text "luz@babyworldonline.net", size: 10
    else
      text "Baby World"
    end
    y_position = cursor - 20
    bounding_box([0, y_position], :width => 200, :height => 100) do
      text "Order for:"
      text " "
      text "#{@customer.first_name} #{@customer.last_name}", size: 12, style: :bold
      text "#{@customer.address}"
      text "#{@customer.city}, #{@customer.state} #{@customer.zip_code}"
      end
 
    bounding_box([215, y_position], :width => 200, :height => 100) do
      text " "
      text " "
      text " "
      text "Phone: #{@customer.phone_num}"
      text "Alt Phone: #{@customer.alt_phone_num}"
    end
  end
 
  def table_content
  text "Items", size: 12, style: :bold
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
    y_position = cursor - 20
    bounding_box([0, y_position], :width => 200, :height => 150) do
      text "Items Total: $#{price_format(@order.items_total)}"
      text "Tax: $#{price_format(@order.tax)}"
      text "Total w/ Tax: $#{price_format(@order.total_with_tax)}"
      text "Delivery: $#{price_format(@order.delivery)}"
      text "Assembly: $#{price_format(@order.assembly)}"
      text "Grand Total: $#{price_format(@order.grand_total)}", size: 14, style: :bold
      text "Desposit: $#{price_format(@order.deposit)}"
      text "Balance Due: $#{price_format(@order.balance_due)}",size: 14, style: :bold
    end
  end
 
  def product_rows
    [['Company', 'Model', 'Description', "Price"]] +
      @products.map do |product|
      [product.company, product.model_type, product.description, "$#{price_format(product.price)}"]
    end
  end

  def text_content
    bounding_box([0, 130], :width => 600, :height => 100) do
      text "Confirmation of pickup"
      text "Customer Signature: ___________________________",size: 14, style: :bold
    end

     bounding_box([-10, 80], :width => 800, :height => 150) do
      text "*Any Order cancelled will require a 20% charge of the total price."
      text "*Refund Ploicy: No cash refunds. Full exchange or store crdit within 30 days of purchase date."
      text "*Please give 24 hour notice for pick up."
      text "*Prices and availability are subject to change at any time without notice."
      text "*Once items are picked up by the customer from the store, Baby World is not responsible for any damamges."
    end
  end
end