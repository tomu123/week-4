class ProductRepresenter < Representable::Decorator
  include Representable::JSON
  property :id
  property :name
  property :description
  property :price
  property :stock
end
