class StripeTransaction < ApplicationRecord
  belongs_to :user
  has_many :stripe_transaction_lines
  has_many :products, through: :stripe_transaction_lines

  accepts_nested_attributes_for :stripe_transaction_lines
end
