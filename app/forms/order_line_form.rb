class OrderLineForm
  include ActiveModel::Model

  attr_accessor :product, :quantity, :price, :total

  validates :product, :quantity, :price, :total, presence: true
  validates :price, :total, numericality: true
  validates :quantity, numericality: { only_integer: true }
  validate :validate_stock

  private

  def validate_stock
    message = "there isn't enough stock of #{product.name}"
    errors.add(:quantity, message) if quantity.present? && (quantity > product.stock)
  end
end
