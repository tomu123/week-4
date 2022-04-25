# frozen_string_literal: true

# Service to like a product
class Cart::CheckoutService < ApplicationService
  attr_reader :current_user

  def initialize(current_user)
    super()
    @current_user = current_user
  end

  def call
    find_cart
    build_order
    if @order.valid?
      @order.save!
      stock_notification
      @cart.destroy
      json = render_json
      [json, @order]
    else
      raise_custom_error
    end
  end

  private

  def find_cart
    @cart = Cart.find_by(user: current_user)
    raise CustomError.new(error: 'Cart Empty', status: :unprocessable_entity) if @cart.blank?
  end

  def build_order
    @order = current_user.orders.build(date: Time.current)
    @cart.line_items.each do |li|
      @order.order_lines.build(product: li.product, quantity: li.quantity, price: li.price, total: li.total)
    end
  end

  def stock_notification
    @order.order_lines.each do |ol|
      stock = ol.product.stock
      user_id = ol.product.likes.last.user_id
      product_id = ol.product_id
      ProductMailer.with(product_id: product_id, recipient_id: user_id).stock_notification.deliver_later if stock <= 3
    end
  end

  def render_json
    OrderRepresenter.jsonapi_new(@order).to_json
  end

  def raise_custom_error
    error = :argument_error
    status = :unprocessable_entity
    errors = @order.order_lines.to_a.map do |ol|
      ol.errors.to_hash
    end
    raise CustomError.new(error: error, status: status, message: errors)
  end
end
