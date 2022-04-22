# frozen_string_literal: true

# Service to unlike a like
class Like::DestroyService < ApplicationService
  attr_reader :product_id, :current_user

  def initialize(product_id, current_user)
    super()
    @product_id = product_id
    @current_user = current_user
  end

  def call
    find_like
    destroy
    update_like_count
  end

  private

  def find_like
    @like = Like.find_by(product_id: product_id, user: current_user)
    message = "Couldn't find Like with 'product_id' = #{product_id} for current user"
    raise ActiveRecord::RecordNotFound, message if @like.blank?
  end

  def destroy
    @like.destroy
  end

  def update_like_count
    UpdateLikeCountJob.perform_later(product_id, -1)
  end
end
