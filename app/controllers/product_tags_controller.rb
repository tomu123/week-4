# frozen_string_literal: true

class ProductTagsController < ApplicationController
  before_action :only_admin

  def create
    product_tag = ProductTag.new(tag_id: params[:product_tag][:tag], product_id: params[:product_id])
    if product_tag.save
      flash[:notice] = "You have added #{product_tag.tag.name} to #{product_tag.product.name} tags!"
    else
      flash[:alert] = product_tag.errors.full_messages
    end
    redirect_to product_path(product_tag.product)
  end

  def destroy
    product_tag = ProductTag.find(params[:id])
    flash[:notice] = "You have deleted #{product_tag.tag.name} from #{product_tag.product.name} tags!"
    product_tag.destroy
    redirect_to product_path(product_tag.product)
  end

  private

  def only_admin
    redirect_to products_path unless user_signed_in? && current_user.admin
  end
end
