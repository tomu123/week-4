class PaymentMailer < ApplicationMailer
  def successfull_purchase_notification
    @order = Order.includes(order_lines: :product).find_by(id: params[:order_id])
    @recipient = User.find_by(id: params[:recipient_id])
    return if @order.blank? || @recipient.blank?

    mail(to: @recipient.email, subject: 'ApplaudoStudios - Successfull Purchase')
  end

  def failed_purchase_notification
    timestamp = params[:timestamp]
    @failure_code = params[:failure_code]
    @failure_message = params[:failure_message]
    @recipient = User.find_by(id: params[:recipient_id])
    return if @recipient.blank? || @failure_code.blank? || @failure_message.blank? || timestamp.blank?

    @date = Time.at(timestamp)
    mail(to: @recipient.email, subject: 'ApplaudoStudios - Failed Purchase')
  end
end
