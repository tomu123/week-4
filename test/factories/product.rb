# This will guess the Product class
FactoryBot.define do
  factory :product do
    name{Faker::Commerce.product_name}
    description{ Faker::Lorem.sentence}
    price{ rand(10..100.00).round(2)}
    stock{rand(1..25)}
  end
end
