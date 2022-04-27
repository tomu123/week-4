class ProductMailer < ApplicationMailer
  def stock_notification
    @product = Product.find_by(id: params[:product_id])
    @recipient = User.find_by(id: params[:recipient_id])
    return if @product.blank? || @recipient.blank?

    @image_url = Rails.application.routes.url_helpers.url_for(@product.image.variant(resize_to_limit: [220, 220]))
    attachments.inline['product.jpg'] = @product.image.variant(resize_to_limit: [220, 220]).download
    mail(to: @recipient.email, subject: "Notification Low Stock - Product: #{@product.name}")
  end
end
