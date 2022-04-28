# rubocop:disable Style/Documentation
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  belongs_to :user

  def total
    line_items.to_a.map(&:total).reduce(:+)
  end
end
