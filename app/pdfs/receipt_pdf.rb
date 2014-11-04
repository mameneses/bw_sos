require 'prawn/table'

class ReceiptPdf < Prawn::Document
  def initialize(customer, order, products)
    super()
    @customer = customer
    @order = order
    @products = products
    header
    text_content
    table_content
  end
 
  def header
    #This inserts an image in the pdf file and sets the size of the image
    text "Baby World", size: 15, style: :bold
    text "4400 Telegraph Ave", size: 12
    text "Oakland, CA 94609"
    text "(510) 282-4406"
    text "http://www.babyworldonline.net"
    text "luz@babyworldonline.net"
  end
 
  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 20
 
    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
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
  #   # This makes a call to order_rows and gets back an array of data that will populate the columns and rows of a table
  #   # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
  #   # Then I set the table column widths
  text "Items", size: 12, style: :bold
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      # se1lf.column_widths = [200, 300, 200]
    end
  end
 
  def product_rows
    [['Company', 'Model', 'Description', "Price"]] +
      @products.map do |product|
      [product.company, product.model_type, product.description, product.price]
    end
  end
end