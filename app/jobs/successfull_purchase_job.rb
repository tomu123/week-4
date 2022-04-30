class SuccessfullPurchaseJob < ApplicationJob
  queue_as :default

  def perform(event = {})
    # Do something later
    email = event.dig(:data, :object, :billing_details, :email)
    @user = User.find_by(email: email)
    @cart = @user&.cart
    return if @user.blank? || @cart.blank? || @cart.line_items.empty?

    StripeTransaction::CreateService.call(@cart, event)
    json, order = Cart::CreateOrderService.call(@user)
    PaymentMailer.with(order_id: order.id, recipient_id: @user.id).successfull_purchase_notification.deliver_later
  end
end
