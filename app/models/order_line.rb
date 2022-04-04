class OrderLine < ApplicationRecord
  validates :order, :product, :quantity, presence: true
  validate :validate_stock, on: :create

  before_create :set_current_price, :calculate_total
  after_commit :update_stock, :calculate_order_total, on: :create

  belongs_to :order
  belongs_to :product

  private

  def calculate_total
    self.total = quantity * price
  end

  def set_current_price
    self.price = product.price
  end

  def update_stock
    product.stock -= quantity
    product.save
  end

  def calculate_order_total
    reload_order
    sub_totals = order.order_lines.to_a.map { |ol| ol.total }
    new_total = sub_totals.reduce(:+)
    order.update(total: new_total)
  end

  def validate_stock
    errors.add(:quantity, "there isn't enough stock of #{product.name}") if quantity > product.stock
  end
end
