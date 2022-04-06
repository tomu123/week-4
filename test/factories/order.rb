# This will guess the Order class
FactoryBot.define do
  factory :order do
    date {Faker::Date.in_date_period}
    order_status {%w[pending completed cancelled].sample}
  end
end
