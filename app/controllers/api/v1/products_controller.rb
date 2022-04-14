# frozen_string_literal: true

class Api::V1::ProductsController < Api::V1::ApplicationController
  include Pagy::Backend

  before_action :set_product, only: [:show]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @products = Product::SearchService.call(params)
    render json: ProductRepresenter.for_collection.new(@products).to_json, status: 200
  end

  def show
    render json: ProductRepresenter.new(@product).to_json, status: 200
  end

  private

  def product_params
    params.permit(:sort_by_price, :sort_by_name, :sort_by_popularity, :sort_by_sales, :name, :tag, :page, :items)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
