# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show; end

  def checkout
    Cart::CheckoutService.call(@current_user)
    flash[:notice] = 'Your purchase was successful'
    redirect_to products_url
  rescue StandardError => e
    flash.now[:alert] = e.message.values.flatten
    render :show
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end
end
