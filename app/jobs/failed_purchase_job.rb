class FailedPurchaseJob < ApplicationJob
  queue_as :default

  def perform(event = {})
    # Do something later
    email = event.dig(:data, :object, :billing_details, :email)
    @user = User.find_by(email: email)
    @cart = @user&.cart
    return if @user.blank? || @cart.blank? || @cart.line_items.empty?

    StripeTransaction::CreateService.call(@cart, event)
    PaymentMailer.with(timestamp: event.dig(:data, :object, :created),
                       failure_code: event.dig(:data, :object, :failure_code),
                       failure_message: event.dig(:data, :object, :failure_message),
                       recipient_id: @user.id).failed_purchase_notification.deliver_later
  end
end
