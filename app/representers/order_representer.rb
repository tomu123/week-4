class OrderRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :customer do
    property :id
    property :name
  end
  property :date
  property :total
  property :order_status

  collection :order_lines, class: OrderLine, decorator: LineRepresenter
end
