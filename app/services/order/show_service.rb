class Order::ShowService < ApplicationService
  attr_reader :order_id, :current_user

  def initialize(order_id, current_user)
    super()
    @order_id = order_id
    @current_user = current_user
  end

  def call
    find_order
    render_json
  end

  private

  def find_order
    @order = Order.includes(:user, order_lines: :product).find_by(id: order_id, user: @current_user)
    message = "Couldn't find order with 'id' = #{order_id} for current user"
    raise ActiveRecord::RecordNotFound, message if @order.blank?
  end

  def render_json
    OrderRepresenter.jsonapi_new(@order).to_json
  end
end
