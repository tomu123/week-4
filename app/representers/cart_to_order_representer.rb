class CartToOrderRepresenter < ApplicationRepresenter
  property :user
  property :date, exec_context: :decorator
  property :order_status, exec_context: :decorator
  property :total

  collection :line_items, class: LineItem, as: :order_lines_attributes do
    property :product
    property :quantity
    property :price
    property :total
  end

  def date
    Time.current
  end

  def order_status
    'pending'
  end
end
