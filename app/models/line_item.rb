class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total
    quantity * product.price
  end
end
