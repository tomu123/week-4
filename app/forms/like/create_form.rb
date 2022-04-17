# frozen_string_literal: true

# Like Create Form Object
class Like::CreateForm
  include ActiveModel::Model

  attr_accessor :user_id, :product_id

  validates :user_id, :product_id, presence: true
  validate :product_exists?, :user_exists?
  validate :already_liked?, if: -> { Product.exists?(product_id) && User.exists?(user_id) }

  def attributes
    {
      user_id: user_id,
      product_id: product_id
    }
  end

  private

  def product_exists?
    message = "There isn't a Product for the product_id: #{product_id}."
    errors.add(:existence, message) unless Product.exists?(product_id)
  end

  def user_exists?
    message = "There isn't a User for the user_id: #{user_id}."
    errors.add(:existence, message) unless User.exists?(user_id)
  end

  def already_liked?
    message = "User: #{User.find(user_id).name} has already liked the Product: #{Product.find(product_id).name}."
    errors.add(:uniqueness, message) if Like.exists?(user_id: user_id, product_id: product_id)
  end
end
