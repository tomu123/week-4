class FilteredProductsQuery
  FILTER_OPTIONS = %w[name tag].freeze

  def initialize(params = {}, relation = Product.all)
    @params = params
    @relation = relation
  end

  def call
    @params.each do |key, value|
      if key == 'tag'
        tag = Tag.find_by(name: value)
        message = "Couldn't find tag with 'name'='#{value}'"
        raise ActiveRecord::RecordNotFound, message if tag.nil?

        value = tag.id
      end

      @relation = @relation.public_send("search_by_#{key}", value) if FILTER_OPTIONS.include?(key)
    end
    @relation
  end
end
