class CartRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :customer do
    property :id
    property :name
  end
  property :total

  collection :line_items, class: LineItem, decorator: LineRepresenter
end
