# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show; end

  def checkout
    session = Stripe::Checkout::Session.create(Cart::CheckoutService.call(@current_user))
    redirect_to session.url
  rescue CustomError => e
    flash.now[:alert] = e.message&.values&.flatten
    render :show
  rescue StandardError => e
    flash.now[:alert] = e.message
    render :show
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end
end
