# frozen_string_literal: true

# Service to like a product
class Cart::CheckoutService < ApplicationService
  attr_reader :cart, :current_user

  def initialize(cart, current_user)
    super()
    @cart = cart
    @current_user = current_user
  end

  def call
    flash[:alert] = []
    order_lines = []
    order = Order.create!(date: Time.current, user: current_user)
    @cart.line_items.each do |li|
      order_lines << order.order_lines.build(product: li.product, quantity: li.quantity)
      flash[:alert].push(*order_lines.last.errors.full_messages) unless order_lines.last.valid?
    end
    if flash[:alert].empty?
      order_lines.each(&:save!)
      order_lines.each do |ol|
        ProductMailer.with(product: ol.product).stock_notification.deliver_later if ol.product.stock == 3
      end
      @cart.destroy
      flash[:notice] = 'Your purchase was successful'
      redirect_to products_url and return
    else
      order.destroy
      redirect_to cart_path and return
    end
  end
end
