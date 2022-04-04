class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, :belong_to_user!, only: %i[edit destroy update show]

  def index
    @orders = current_user.orders
  end

  def create; end

  def new; end

  def edit; end

  def show; end

  def update; end

  def destroy; end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def belong_to_user!
    redirect_to products_path if (@order.user != current_user) && !current_user.admin
  end
end
