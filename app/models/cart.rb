# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
  belongs_to :user
  # para el representer
  def total
    line_items.to_a.map(&:total).reduce(:+)
  end
end
