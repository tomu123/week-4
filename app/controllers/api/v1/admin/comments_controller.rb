# frozen_string_literal: true

module Api
  module V1
    module Admin
      # admin Comments Controller
      class CommentsController < Api::V1::Admin::ApplicationController
        def index
          json = Comment::SearchService.call(@current_user, comment_params)
          render json: json, status: :ok
        end

        def show
          json = Comment::ShowService.call(params[:id], current_user.admin_role?)
          render json: json, status: :ok
        end

        # def create
        #   json, comment = Comment::CreateService.call(@current_user, comment_params)
        #   render json: json, status: :created, location: api_v1_admin_comment_url(comment)
        # end

        # def update
        #   json = Comment::UpdateService.call(params[:id], comment_params)
        #   render json: json, status: :ok
        # end

        def approve
          Comment::ApproveService.call(params[:id])
          head :no_content
        end

        def destroy
          Comment::DestroyService.call(params[:id])
          head :no_content
        end

        private

        def comment_params
          params.permit(:user_id, :status, :page, :items)
        end
      end
    end
  end
end
