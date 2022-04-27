# frozen_string_literal: true

module Api
  module V1
    # public Products Controller
    class ProductsController < Api::V1::ApplicationController
      def index
        json = Product::SearchService.call(product_params)
        render json: json, status: :ok
      end

      def show
        json = Product::ShowService.call(params[:id])
        render json: json, status: :ok
      end

      private

      def product_params
        params.permit(:sort_by_price, :sort_by_name, :sort_by_popularity, :sort_by_sales, :name, :tag, :page, :items)
      end
    end
  end
end
