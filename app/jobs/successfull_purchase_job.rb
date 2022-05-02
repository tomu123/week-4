class SuccessfullPurchaseJob < ApplicationJob
  queue_as :default

  def perform(event = {})
    # Do something later
    email = event.dig(:data, :object, :billing_details, :email)
    @user = User.find_by(email: email)
    return if @user.blank?

    begin
      StripeTransaction::CreateService.call(@user, event)
      _json, order = Cart::CreateOrderService.call(@user)
    rescue CustomError => e
      raise unless [:argument_error, 'Cart Empty'].include?(e.error)
    end
    PaymentMailer.with(order_id: order.id, recipient_id: @user.id).successfull_purchase_notification.deliver_later
  end
end
