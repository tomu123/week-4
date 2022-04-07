# This will guess the User class
FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    address {Faker::Address.full_address}
    email {Faker::Internet.email}
    password {'123456'}
    user_role { 'customer' }
  end
end
