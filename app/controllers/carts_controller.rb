class CartsController < ApplicationController
  before_action :set_cart, :authenticate_user!

  def show; end

  def checkout
    @order = Order.create!(date: Time.now, user: current_user)
    @cart.line_items.each do |li|
      order_line = @order.order_lines.build(product: li.product, quantity: li.quantity)
      unless order_line.save
        flash[:alert] = order_line.errors.full_messages
        redirect_to checkout_cart_path
      end
    end
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
