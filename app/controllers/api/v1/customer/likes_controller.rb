# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer Likes Controller
      class LikesController < Api::V1::Customer::ApplicationController
        def create
          like = Like::CreateService.call(like_params)
          render json: { message: "User: #{like.user.name} has successfully liked the Product: #{like.product.name}." },
                 status: :created
        end

        def destroy
          Like::DestroyService.call(like_params)
          render json: { message: "Product: #{Product.find(params[:product_id]).name} has been successfully unliked by User: #{User.find(params[:user_id]).name}" },
                 status: :ok
        end

        private

        def like_params
          params[:user_id] = @current_user.id
          params.permit(:product_id, :user_id)
        end
      end
    end
  end
end
