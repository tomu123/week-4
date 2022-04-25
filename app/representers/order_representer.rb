class OrderRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :customer do
    property :id
    property :name
  end
  property :date
  property :total
  property :order_status

  collection :order_lines, class: OrderLine do
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
