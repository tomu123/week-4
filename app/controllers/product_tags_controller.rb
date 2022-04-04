# frozen_string_literal: true

class ProductTagsController < ApplicationController
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
end
