# frozen_string_literal: true

module Api
  module V1
    module Admin
      # admin Products Controller
      class ProductsController < Api::V1::Admin::ApplicationController
        def create
          json, product = Product::CreateService.call(product_params)
          render json: json, status: :created, location: api_v1_product_url(product)
        end

        def update
          json = Product::UpdateService.call(params[:id], product_params)
          render json: json, status: :ok
        end

        def destroy
          Product::DestroyService.call(params[:id])
          head :no_content
        end

        def recover
          json = Product::RecoverService.call(params[:id])
          render json: json, status: :ok
        end

        private

        def product_params
          params.require(:data).permit(:name, :description, :price, :stock)
        end
      end
    end
  end
end
