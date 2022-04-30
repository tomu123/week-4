class StripeTransactionRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :customer do
    property :id
    property :name
  end
  property :date
  property :amount
  property :card_country
  property :currency
  property :status
  property :card_brand
  property :card_funding
  property :network

  collection :stripe_transaction_lines, class: StripeTransactionLine, decorator: LineRepresenter
end
