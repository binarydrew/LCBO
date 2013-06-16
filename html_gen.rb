require 'json'
require 'open-uri'
require 'rubygems'

class HtmlGen

  def initialize
    @time = Time.new
  end

  def retrieve_clean_data(url)
    raw_data = open(url).read
    clean_data = JSON.parse(raw_data)
    results = clean_data["result"]
  end

  def print_header
      puts "<html>"
      puts " <head>"
      puts " <title>Connoisseur</title>"
      puts " <link rel='stylesheet' href='normalize.css' type='text/css'>"
      puts " <link rel='stylesheet' href='styles.css' type='text/css'>"
      puts " </head>"
      puts " <body>"
      puts "<h1> Items on sale at LCBO on #{@time} </h1>"
  end

    def print_footer
      puts " </body>"
      puts "</html>"
    end

  def fix_price(cents_string)
    cents_string.to_f/100
  end

  def all_products(a)
    products = retrieve_clean_data(a)

      print_header
    products.each do |product|
      puts "<div class='product'>"
      puts " <h3>#{product['name']}</h3>"
      puts " <img src='#{product['image_url']}' class='product-image'/>"
      puts " <ul class='product-data'>"
      puts " <li>#{product['package']}</li>"
      puts " <li><strong>Sale price: </strong>$#{fix_price(product['price_in_cents'])}</li>"
      puts " <li>Regular Price $#{fix_price(product['regular_price_in_cents'])}</li>"
      puts " <li>Saving of $#{fix_price(product['limited_time_offer_savings_in_cents'])}</li>"
      puts " <li> Ends on #{product['limited_time_offer_ends_on']} </li>"
      puts " </ul>"
      puts "</div>"
      print_footer
    end
  end

end


b=HtmlGen.new
b.all_products("http://lcboapi.com/products?q=&order=limited_time_offer_savings_in_cents.desc")

