module CustomerHelper
  def clean_up_phone(num)
    num = num.gsub(/[.\-()\W]/, '')
  end
end
