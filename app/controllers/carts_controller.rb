class CartsController < ApplicationController
  before_action :set_cart

  def show; end

  def checkout
    @order = Order.create!(date: Time.now, user: current_user)
    @cart.line_items.each do |li|
      order_line = @order.order_lines.build(product: li.product, quantity: li.quantity)
      if order_line.save
        redirect_to products_url
      else
        flash[:alert] = order_line.errors.full_messages
        render :checkout
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
