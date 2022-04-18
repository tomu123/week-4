# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer Orders Controller
      class OrdersController < Api::V1::Customer::ApplicationController
        include Pagy::Backend

        before_action :set_order, :order_access, only: [:show]
        after_action { pagy_headers_merge(@pagy) if @pagy }

        def index
          @pagy, @orders = Order::SearchService.call(order_params, @current_user.orders)
          render json: OrderRepresenter.for_collection.new(@orders).to_json, status: 200
        end

        def show
          render json: OrderRepresenter.new(@order).to_json, status: 200
        end

        private

        def order_params
          params.permit(:page, :items)
        end

        def set_order
          @order = Order.find(params[:id])
        end

        def order_access
          message = "Current User: #{@current_user.name} doesn't have access to order n##{params[:id]}"
          raise CustomError.new('Access Denied', message, :unauthorized) if @order.user != @current_user
        end
      end
    end
  end
end
