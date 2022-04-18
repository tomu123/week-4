# frozen_string_literal: true

module Api
  module V1
    module Support
      # support Products Controller
      class ProductsController < Api::V1::Support::ApplicationController
        def update
          @product = Product::UpdateService.call(params[:id], product_params)
          render json: ProductRepresenter.new(@product).to_json, status: :ok
        end

        private

        def product_params
          raise ArgumentError, "Support Staff can't modify price of products." unless params[:product][:price].blank?

          params.require(:product).permit(:name, :description, :stock)
        end
      end
    end
  end
end
