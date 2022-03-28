class CartsController < ApplicationController
  before_action :set_cart
  before_action :authenticate_user!, only: [:checkout]

  def show; end

  def checkout
    @order = Order.create!(date: Time.now, user: current_user)
    @cart.line_items.each do |li|
      order_line = @order.order_lines.build(product: li.product, quantity: li.quantity)
      next if order_line.save

      flash[:alert] = order_line.errors.full_messages
      li.destroy
      @order.destroy
      redirect_to cart_path
      return
    end
    @order.destroy if @order.order_lines.empty?
    @cart.destroy
    redirect_to products_url
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
