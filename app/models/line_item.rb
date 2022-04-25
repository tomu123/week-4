# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def price
    product.price
  end

  def total
    quantity * price
  end
end
