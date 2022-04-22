# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart
  before_action :authenticate_user!, only: [:checkout]

  def show; end

  def checkout
    unless @cart.line_items.empty?
      flash[:alert] = []
      order_lines = []
      order = Order.create!(date: Time.now, user: current_user)
      @cart.line_items.each do |li|
        order_lines << order.order_lines.build(product: li.product, quantity: li.quantity)
        flash[:alert].push(*order_lines.last.errors.full_messages) unless order_lines.last.valid?
      end
      if flash[:alert].empty?
        order_lines.each(&:save!)
        order_lines.each do |ol|
          ProductMailer.with(product: ol.product).stock_notification.deliver_later if ol.product.stock <= 3
        end
        @cart.destroy
        flash[:notice] = 'Your purchase was successful'
        redirect_to products_url and return
      else
        order.destroy
        redirect_to cart_path and return
      end
    end
    flash.now[:alert] = 'Your Cart is empty!'
    render :show
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
