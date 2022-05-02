class FailedPurchaseJob < ApplicationJob
  queue_as :default

  def perform(event = {})
    # Do something later
    email = event.dig(:data, :object, :billing_details, :email)
    @user = User.find_by(email: email)
    return if @user.blank?

    begin
      StripeTransaction::CreateService.call(@user, event)
    rescue CustomError => e
      raise unless [:argument_error, 'Cart Empty'].include?(e.error)
    end
    PaymentMailer.with(timestamp: event.dig(:data, :object, :created),
                       failure_code: event.dig(:data, :object, :failure_code),
                       failure_message: event.dig(:data, :object, :failure_message),
                       recipient_id: @user.id).failed_purchase_notification.deliver_later
  end
end
