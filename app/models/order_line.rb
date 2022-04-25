# frozen_string_literal: true

class OrderLine < ApplicationRecord
  validates :order, :product, :quantity, :price, :total, presence: true
  validates :price, :total, numericality: true
  validates :quantity, numericality: { only_integer: true }
  validate :validate_stock, on: :create

  after_commit :update_stock, :calculate_order_total, on: :create

  belongs_to :order
  belongs_to :product

  private

  def validate_stock
    message = "there isn't enough stock of #{product.name}"
    errors.add(:quantity, message) if quantity.present? && (quantity > product.stock)
  end

  def update_stock
    product.stock -= quantity
    product.save
  end

  # eliminar y colocar en servicio checkout
  def calculate_order_total
    reload_order
    sub_totals = order.order_lines.to_a.map(&:total)
    new_total = sub_totals.reduce(:+)
    order.update(total: new_total)
  end
end
