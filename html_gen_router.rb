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

  end

    def print_footer
      puts " </body>"
      puts "</html>"
    end

  def fix_price(cents_string)
    cents_string.to_f/100
  end

  def sale_products(a)
    products = retrieve_clean_data(a)

      print_header
      puts "<h1> Items on sale at LCBO on #{@time} in descending order</h1>"
    products.each do |product|
      puts "<div class='product'>"
      puts " <h3>#{product['name']}</h3>"
      puts " <img src='#{product['image_url']}' class='product-image'/>"
      puts " <ul class='product-data'>"
      puts " <li>#{product['package']}</li>"
      puts " <li><strong>Sale price: </strong>$#{fix_price(product['price_in_cents'])}</li>"
      puts " <li>Regular Price $#{fix_price(product['regular_price_in_cents'])}</li>"
      puts " <li>Saving of $#{fix_price(product['limited_time_offer_savings_in_cents'])}0</li>"
      puts " <li> Ends on #{product['limited_time_offer_ends_on']} </li>"
      puts " </ul>"
      puts "</div>"
      print_footer
    end
  end

def all_products(a)
  products = retrieve_clean_data(a)
print_header

    puts "<h1>All products</h1>"


    products.each do |product|
      puts "<div class='product'>"
      puts " <h2>#{product['name']}</h2>"
      puts " <img src='#{product['image_thumb_url']}' class='product-thumbnail'/>"
      puts " <ul class='product-data'>"
      puts " <li>id: #{product['id']}</li>"
      puts " <li>#{product['producer_name']}</li>"
      puts " <li>#{product['primary_category']}</li>"
      puts " <li>#{product['secondary_category']}</li>"
      puts " <li>#{product['volume_in_milliliters']} ml</li>"
      puts " <li>$#{fix_price(product['price_in_cents'])}</li>"
      puts " </ul>"
      puts "</div>"
    end

    puts "<footer>"
    puts " For more info see the <a href='http://lcboapi.com/docs/products'>products API docs</a>."
    puts "</footer>"

    print_footer
  end

end





