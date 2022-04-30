class StripeTransactionLine < ApplicationRecord
  belongs_to :stripe_transaction
  belongs_to :product
end
