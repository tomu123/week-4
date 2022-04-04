class LikesController < ApplicationController
  def create
    like = Like.create(user: current_user, product_id: params[:product_id])
    flash[:notice] = "You have added #{like.product.name} to your favorites!"
    redirect_to products_path
  end

  def destroy
    like = Like.find_by(user: current_user, product_id: params[:product_id])
    flash[:notice] = "You have deleted #{like.product.name} from your favorites!"
    like.destroy
    redirect_to products_path
  end
end
