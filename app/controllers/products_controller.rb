class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit destroy update]
  before_action :only_admin, except: %i[index show]

  def index
    @products = if params[:search_key].blank?
                  Product.all
                else
                  Product.search_by_name(params[:search_key])
                end
  end

  def create
    @product = Product.new(product_params)
    render :new unless @product.save
  end

  def new
    @product = Product.new
  end

  def edit; end

  def show; end

  def update
    @product.update(product_params)
    redirect_to products_url
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
