# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, :belong_to_user!, only: %i[edit destroy update show]

  def index
    @orders = current_user.admin_role? ? Order.all : current_user.orders
  end

  def show; end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def belong_to_user!
    redirect_to products_path if (@order.user != current_user) && !current_user.admin_role?
  end
end
