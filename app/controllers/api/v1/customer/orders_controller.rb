# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer Orders Controller
      class OrdersController < Api::V1::Customer::ApplicationController
        def index
          json = Order::SearchService.call(order_params, @current_user.orders)
          render json: json, status: :ok
        end

        def show
          json = Order::ShowService.call(params[:id], @current_user)
          render json: json, status: :ok
        end

        private

        def order_params
          params.permit(:page, :items)
        end
      end
    end
  end
end
