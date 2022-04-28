class OrderForm
  include ActiveModel::Model

  attr_accessor :user, :date, :order_status, :total, :order_lines

  validates :user, :date, :order_status, :total, presence: true
  validates :total, numericality: true
  validate :order_status_valid?, :order_lines_valid?

  def order_lines_attributes=(attributes)
    @order_lines ||= []
    attributes.each do |order_line_params|
      order_line = OrderLineForm.new(order_line_params)
      @order_lines << order_line
    end
  end

  private

  def order_lines_valid?
    order_lines.each do |ol|
      errors.merge!(ol.errors) unless ol.valid?
    end
  end

  def order_status_valid?
    Order.order_statuses.include?(order_status)
  end
end
