class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  def total
    line_items.to_a.map(&:total).reduce(:+)
  end
end
