class Product::Search < ApplicationService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    products = FilteredProductsQuery.new(filter_params).call
    OrderedProductsQuery.new(sort_params, products).call
  end

  private

  def filter_params
    @params.slice(:name, :tag)
  end

  def sort_params
    @params.slice(:sort_by_price, :sort_by_name, :sort_by_popularity, :sort_by_sales)
  end
end
