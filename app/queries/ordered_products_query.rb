class OrderedProductsQuery
  SORT_OPTIONS = %w[sort_by_price sort_by_name sort_by_popularity sort_by_sales].freeze

  def initialize(params = {}, relation = Product.all)
    @params = params
    @relation = relation
  end

  def call
    @params.each do |key, value|
      @relation = @relation.public_send(key, direction(value)) if SORT_OPTIONS.include?(key)
    end
    @relation = @relation.sort_by_name(:asc) unless @params.include?('sort_by_name')
    @relation
  end

  private

  def direction(value)
    raise ArgumentError, "#{value}, it's not a valid sorting option(asc,desc)" unless %w[asc desc].include?(value)

    value.to_sym
  end
end
