# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    if @line_item = @cart.line_items.find_by(product_id: params[:product_id])
      @line_item.update(quantity: @line_item.quantity + params[:quantity].to_i)
    else
      @line_item = @cart.line_items.create(product_id: params[:product_id], quantity: params[:quantity])
    end
  end

  def destroy
    @line_item = @cart.line_items.find(params[:id])
    @line_item.destroy
    redirect_to cart_url
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end
end
