class PaginationQuery
  include Pagy::Backend

  def initialize(params = {}, relation = Product.all)
    @params = params
    @relation = relation
  end

  def call
    pagy(@relation, items: items, page: page)
  end

  private

  def items
    @params.include?(:items) ? @params[:items] : Pagy::DEFAULT[:items]
  end

  def page
    @params.include?(:page) ? @params[:page] : Pagy::DEFAULT[:page]
  end
end
