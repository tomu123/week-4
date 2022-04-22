# frozen_string_literal: true

# Service to like a product
class Like::CreateService < ApplicationService
  attr_reader :product_id, :current_user

  def initialize(product_id, current_user)
    super()
    @product_id = product_id
    @current_user = current_user
  end

  def call
    find_product
    validate
    create
    update_like_count
    render_json
  end

  private

  def find_product
    @product = Product.find(product_id)
  end

  def validate
    message = "Current user has already liked the Product: #{Product.find(product_id).name}."
    raise ArgumentError, message if Like.exists?(product: @product, user: current_user)
  end

  def create
    @like = @product.likes.create(user: current_user)
  end

  def update_like_count
    UpdateLikeCountJob.perform_later(@product.id, +1)
  end

  def render_json
    LikeRepresenter.jsonapi_new(@like).to_json
  end
end
