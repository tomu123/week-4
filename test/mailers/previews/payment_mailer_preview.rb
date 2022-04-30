# Preview all emails at http://localhost:3000/rails/mailers/payment_mailer
class PaymentMailerPreview < ActionMailer::Preview
  def successfull_purchase_notification
    PaymentMailer.with(order_id: Order.last.id, recipient_id: User.last.id).successfull_purchase_notification
  end

  def failed_purchase_notification
    PaymentMailer.with(timestamp: 1_651_267_712, failure_code: 'card_declined',
                       failure_message: 'Your card has insufficient funds.',
                       recipient_id: User.last.id).failed_purchase_notification
  end
end
