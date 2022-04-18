class Product::SearchService < ApplicationService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    products = FilteredProductsQuery.new(params).call
    products = OrderedProductsQuery.new(params, products).call
    PaginationQuery.new(params, products).call
  end
end
