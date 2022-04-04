class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_product, only: %i[edit destroy update show]
  before_action :only_admin, except: %i[index show]

  def index
    @products = Product.all
    @products = @products.search_by_name(params[:search_key]) unless params[:search_key].blank?
    unless params[:order_by_popular].blank?
      @products = @products.unscope(:order).sort_by_popularity(params[:order_by_popular] == 'true').sort_by_name(false)
    end
    @products = @products.unscope(:order).sort_by_name(params[:order_by_name] == 'true') unless params[:order_by_name].blank?
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def new
    @product = Product.new
  end

  def edit; end

  def show; end

  def update
    @product.update(product_params)
    redirect_to product_url(@product)
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def only_admin
    redirect_to products_path unless user_signed_in? && current_user.admin
  end
end
