class FilteredProductsQuery
  FILTER_OPTIONS = %w[name tag].freeze

  def initialize(params = {}, relation = Product.all)
    @params = params
    @relation = relation
  end

  def call
    @params.each do |key, value|
      @relation = @relation.public_send("search_by_#{key}", value) if FILTER_OPTIONS.include?(key)
    end
    @relation
  end
end
