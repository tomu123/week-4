class CartRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :customer do
    property :id
    property :name
  end
  property :total

  collection :line_items, class: LineItem do
    property :id
    property :product do
      property :id
      property :name
    end
    property :quantity
    property :price, as: :unit_price
    property :total, as: :subtotal
  end
end
