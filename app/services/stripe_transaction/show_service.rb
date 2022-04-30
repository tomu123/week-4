class StripeTransaction::ShowService < ApplicationService
  attr_reader :stripe_transaction_id, :current_user

  def initialize(stripe_transaction_id, current_user)
    super()
    @stripe_transaction_id = stripe_transaction_id
    @current_user = current_user
  end

  def call
    find_stripe_transaction
    render_json
  end

  private

  def find_stripe_transaction
    @stripe_transaction = StripeTransaction.includes(:user, stripe_transaction_lines: :product).find_by(
      @current_user.admin_role? ? { id: stripe_transaction_id } : { id: stripe_transaction_id, user: @current_user }
    )
    message = "Couldn't find stripe_transaction with 'id' = #{stripe_transaction_id}"
    raise ActiveRecord::RecordNotFound, message if @stripe_transaction.blank?
  end

  def render_json
    StripeTransactionRepresenter.jsonapi_new(@stripe_transaction).to_json
  end
end
