# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer Carts Controller
      class CartsController < Api::V1::Customer::ApplicationController
        def show
          json = Cart::ShowService.call(@current_user)
          render json: json, status: :ok
        end

        def checkout
          json, order = Cart::CheckoutService.call(@current_user)
          render json: json, status: :created, location: api_v1_customer_order_url(order)
        end
      end
    end
  end
end
