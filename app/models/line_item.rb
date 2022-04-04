# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :cart, :product, :quantity, presence: true

  def total
    quantity * product.price
  end
end
