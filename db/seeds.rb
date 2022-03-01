# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ElementSale.delete_all
Element.delete_all
prices = [50,30,20,15,75,20,10]
("A".."G").each_with_index do |code,index|
  element = Element.new(code:code, price: prices[index])
  if code == "A"
    element.element_sales.build(quantity: 3, sale_price: 130)
    element.sale = true
  elsif code =="B"
    element.element_sales.build(quantity: 2, sale_price: 45)
    element.sale = true
  elsif code =="E"
    element.element_sales.build(quantity: 3, sale_price: 120)
    element.sale = true
  end
  element.save
end
