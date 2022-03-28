class ProductsController < ApplicationController
  before_action :set_cart

  def index
    @products = Product.all
  end

  def create; end

  def new; end

  def edit; end

  def show; end

  def update; end

  def destroy; end

  def add_to_cart
    @line_item = @cart.line_items.create(product_id: params[:id])
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end
end
