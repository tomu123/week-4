# frozen_string_literal: true

module Api
  module V1
    module Support
      # support Products Controller
      class ProductsController < Api::V1::Support::ApplicationController
        def update
          json = Product::UpdateService.call(params[:id], product_params)
          render json: json, status: :ok
        end

        private

        def product_params
          params.require(:data).permit(:name, :description, :stock)
        end
      end
    end
  end
end
