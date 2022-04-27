class LineItemRepresenter < ApplicationRepresenter
  property :id
  property :product do
    property :id
    property :name
  end
  property :quantity
  property :price, as: :unit_price
  property :total, as: :subtotal
end
