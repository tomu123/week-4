class OrderForm
  include ActiveModel::Model

  attr_accessor :user, :date, :order_status, :total, :order_lines_attributes

  validates :user, :date, :order_status, :total, presence: true
  validates :total, numericality: true
  validate :order_status_valid?, :order_lines_valid?

  private

  def order_lines_valid?
    order_lines_attributes.each do |order_line_params|
      order_line = OrderLineForm.new(order_line_params)
      errors.merge!(order_line.errors) unless order_line.valid?
    end
  end

  def order_status_valid?
    Order.order_statuses.include?(order_status)
  end
end
