# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

5.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: Faker::Address.full_address,
               email: Faker::Internet.email, password: '123456')
end

20.times do
  Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence, price: rand(10..100.00).round(2),
                  stock: rand(1..25))
end

products = Product.all
users = User.all
10.times do
  order = Order.create!(date: Faker::Date.in_date_period, user: users.sample,
                        order_status: %w[pending completed cancelled].sample)
  (1..rand(1..5)).each do
    product = products.sample
    product = products.sample until product.stock.positive?
    OrderLine.create!(order: order, product: product, quantity: rand(1..product.stock))
  end
end
