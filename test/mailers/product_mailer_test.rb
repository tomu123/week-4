require 'test_helper'

class ProductMailerTest < ActionMailer::TestCase
  test 'stock_notification' do
    # Create the email and store it for further assertions
    product = create(:product)
    customer = create(:user)
    email = ProductMailer.with(product_id: product.id, recipient_id: customer.id).stock_notification

    # pasar al fixture files la imagen
    product.image.attach(io: File.open('/home/tomukomatsu/Pictures/product_placeholder.jpg'), filename: 'test.jpg')

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['tomu5642514@gmail.com'], email.from
    assert_equal [customer.email], email.to
    assert_equal "Notification Low Stock - Product: #{product.name}", email.subject

    product.image.variant(resize_to_limit: [220, 220]).image.purge
    product.image.purge
  end
end
