class Order::SearchService < ApplicationService
  attr_reader :params, :relation

  def initialize(params = {}, relation = Order.all)
    super()
    @params = params
    @relation = relation
  end

  def call
    PaginationQuery.new(params, relation).call
  end
end
