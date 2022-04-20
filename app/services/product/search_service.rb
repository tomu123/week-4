class Product::SearchService < SearchService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    products = FilteredProductsQuery.new(params).call
    products = OrderedProductsQuery.new(params, products).call
    pagy, products = PaginationService.call(params, products)
    render_json(ProductRepresenter, products, pagy)
  end
end
