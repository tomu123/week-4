# frozen_string_literal: true

module Api
  module V1
    module Admin
      # admin StripeTransactions Controller
      class StripeTransactionsController < Api::V1::Admin::ApplicationController
        def index
          json = StripeTransaction::SearchService.call(stripe_transaction_params)
          render json: json, status: :ok
        end

        def show
          json = StripeTransaction::ShowService.call(params[:id], @current_user)
          render json: json, status: :ok
        end

        private

        def stripe_transaction_params
          params.permit(:page, :items)
        end
      end
    end
  end
end
