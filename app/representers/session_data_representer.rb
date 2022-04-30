class SessionDataRepresenter < ApplicationRepresenter
  collection :line_items, class: LineItem do
    nested :price_data do
      property :currency, getter: ->(_options) { 'usd' }
      property :product, as: :product_data do
        property :name
        property :description
      end
      property :price, as: :unit_amount_decimal, getter: ->(represented:, **) { represented.price * 100 }
    end
    property :quantity
  end
  property :customer_email, getter: ->(represented:, **) { represented.user.email }
  property :mode, getter: ->(_options) { 'payment' }
  property :success_url, getter: ->(_options) { Rails.application.routes.url_helpers.url_for(Product.new) }
  property :cancel_url, getter: ->(represented:, **) { Rails.application.routes.url_helpers.url_for(represented) }
end
