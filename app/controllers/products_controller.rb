# frozen_string_literal: true

class ProductsController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[edit destroy update show]
  before_action :only_admin, except: %i[index show edit update]
  before_action :admin_or_support, only: %i[edit update]

  def index
    @products = Product::Search.call(params)
  end

  def create
    @product = Product.new(product_params)
    flash[:notice] = "Product was successfully created." if @product.save
    respond_with @product
  end

  def new
    @product = Product.new
  end

  def edit; end

  def show; end

  def update
    flash[:notice] = "Product was successfully updated." if @product.update(product_params)
    respond_with @product
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private

  def product_params
    return(params.require(:product).permit(:name, :description, :price, :stock)) if current_user.admin_role?
    return(params.require(:product).permit(:name, :description, :stock)) if current_user.support_role?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def only_admin
    redirect_to products_path unless user_signed_in? && current_user.admin_role?
  end

  def admin_or_support
    redirect_to products_path unless user_signed_in? && (current_user.admin_role? || current_user.support_role?)
  end
end
