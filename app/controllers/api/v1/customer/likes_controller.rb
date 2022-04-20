# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer Likes Controller
      class LikesController < Api::V1::Customer::ApplicationController
        def create
          json = Like::CreateService.call(params[:product_id], @current_user)
          render json: json, status: :created
        end

        def destroy
          Like::DestroyService.call(params[:product_id], @current_user)
          head :no_content
        end
      end
    end
  end
end
