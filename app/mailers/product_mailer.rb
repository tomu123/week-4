class ProductMailer < ApplicationMailer
  def stock_notification
    @product = params[:product]
    recipient = @product.likes.last.user
    @image_url = Rails.application.routes.url_helpers.url_for(@product.image.variant(resize_to_limit: [220, 220]))
    attachments.inline['product.jpg'] = @product.image.variant(resize_to_limit: [220, 220]).download
    mail(to: 'tomu5642514@gmail.com', subject: "Notification Low Stock - Product: #{@product.name}")
    # ProductMailer.with(product: @product).stock_notification.deliver_now
  end
end
