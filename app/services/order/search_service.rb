class Order::SearchService < SearchService
  attr_reader :params, :relation

  def initialize(params = {}, relation = Order.all)
    super()
    @params = params
    @relation = relation
  end

  def call
    pagy, orders = PaginationService.call(params, relation)
    render_json(OrderRepresenter, orders, pagy)
  end
end
