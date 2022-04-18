# frozen_string_literal: true

module Api
  module V1
    module Admin
      # admin Products Controller
      class ProductsController < Api::V1::Admin::ApplicationController
        def create
          @product = Product::CreateService.call(product_params)
          render json: ProductRepresenter.new(@product).to_json, status: :created,
                 location: api_v1_product_url(@product)
        end

        def update
          @product = Product::UpdateService.call(params[:id], product_params)
          render json: ProductRepresenter.new(@product).to_json, status: :ok
        end

        def destroy
          @product = Product::DestroyService.call(params[:id])
          message = "Product: #{@product.name} has been successfully deleted."
          render json: { message: message }, status: :ok
        end

        private

        def product_params
          params.require(:product).permit(:name, :description, :price, :stock)
        end
      end
    end
  end
end
