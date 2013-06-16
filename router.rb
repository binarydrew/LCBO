require_relative 'html_gen_router'

generator = HtmlGen.new
case
  when ARGV.empty?
    puts "This file accepts one arguments, please type: ruby filename.rb ARGV0"
  when ARGV[0] == "list"
    generator.all_products("http://lcboapi.com/products")
  when ARGV[0] == "sale"
    generator.sale_products("http://lcboapi.com/products?q=&order=limited_time_offer_savings_in_cents.desc")
  else
    puts "Invalid entry please use 'list' to list all items or 'sale' for list of sale items"

end
