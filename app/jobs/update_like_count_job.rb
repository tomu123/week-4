class UpdateLikeCountJob < ApplicationJob
  queue_as :default

  def perform(product_id, diff)
    # Do something later
    product = Product.find_by(id: product_id)
    return if product.blank?

    puts "Product: #{product.name} , old_like_count: #{product.like_count}"
    product.like_count ||= 0
    product.like_count += diff
    product.save!
    puts "Product: #{product.name} , new_like_count: #{product.like_count}"
  end
end
