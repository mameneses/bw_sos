require 'prawn/table'

class ReceiptPdf < Prawn::Document
  include ActionView::Helpers::NumberHelper
  def initialize(customer, order, products)
    super()
    @customer = customer
    @order = order
    @products = products
    header
    table_content
    text_content
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
      text "Phone: #{number_to_phone(@customer.phone_num, area_code: true)}"
      text "Alt Phone: #{number_to_phone(@customer.alt_phone_num, area_code: true)}"
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
      text "Items Total: #{number_to_currency(@order.items_total)}"
      text "Tax: #{number_to_currency(@order.tax)}"
      text "Total w/ Tax: #{number_to_currency(@order.total_with_tax)}"
      text "Delivery w/ Tax: #{number_to_currency(@order.delivery_with_tax)}"
      text "Assembly: #{number_to_currency(@order.assembly)}"
      text "Grand Total: #{number_to_currency(@order.grand_total)}", size: 14, style: :bold
      text "Desposit: #{number_to_currency(@order.deposit)}"
      text "Balance Due: #{number_to_currency(@order.balance_due)}",size: 14, style: :bold
    end
  end

  def format_discount (decimal)
    if decimal == 0 || decimal == nil
      "None"
    else
      number_to_percentage((decimal * 100), precision: 0)
    end
  end
 
  def product_rows
    [['Company', 'Model', 'Description', "Price", "Discount"]] +
      @products.map do |product|
      [product.company, product.model_type, product.description, "#{number_to_currency(product.price)}","#{format_discount(product.discount)}"]
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