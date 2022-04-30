class StripeTransaction::SearchService < SearchService
  attr_reader :params, :relation

  def initialize(params = {}, relation = StripeTransaction.all)
    super()
    @params = params
    @relation = relation
  end

  def call
    pagy, stripe_transactions = PaginationService.call(params, relation)
    render_json(StripeTransactionRepresenter, stripe_transactions.includes(:user, stripe_transaction_lines: :product),
                pagy)
  end
end
