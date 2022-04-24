# frozen_string_literal: true

module Api
  module V1
    module Admin
      # admin Users Controller
      class UsersController < Api::V1::Admin::ApplicationController
        def index
          json = User::SearchService.call(user_params)
          render json: json, status: 200
        end

        def show
          json = User::ShowService.call(params[:id])
          render json: json, status: 200
        end

        def create
          json, user = User::CreateService.call(user_params[:data])
          render json: json, status: :created, location: api_v1_admin_user_url(user)
        end

        def update
          json = User::UpdateService.call(params[:id], user_params[:data])
          render json: json, status: :ok
        end

        def destroy
          User::DestroyService.call(params[:id])
          head :no_content
        end

        private

        def user_params
          params.permit(:page, :items, data: %i[email password first_name last_name address user_role])
        end
      end
    end
  end
end
