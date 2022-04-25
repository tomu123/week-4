class LineForm
  include ActiveModel::Model

  attr_accessor :quantity

  validates :quantity, numericality: { only_integer: true }
end
