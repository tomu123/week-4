# frozen_string_literal: true

module Api
  module V1
    module Customer
      # customer LineItems Controller
      class LineItemsController < Api::V1::Customer::ApplicationController
        def add_product
          LineItem::AddProductService.call(@current_user, line_item_params)
          head :no_content
        end

        def update
          LineItem::UpdateService.call(@current_user, params[:id], line_item_params)
          head :no_content
        end

        def destroy
          LineItem::DestroyService.call(@current_user, params[:id])
          head :no_content
        end

        private

        def line_item_params
          params.require(:data).permit(:product_id, :quantity)
        end
      end
    end
  end
end
