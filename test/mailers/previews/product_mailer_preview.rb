# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview
  def stock_notification
    ProductMailer.with(product: Product.first).stock_notification
  end
end
