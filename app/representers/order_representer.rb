class OrderRepresenter < Representable::Decorator
  include Representable::JSON
  property :id
  property :user do
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
    property :price
    property :total
  end
end
