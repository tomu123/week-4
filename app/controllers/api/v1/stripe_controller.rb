# frozen_string_literal: true

module Api
  module V1
    # public Stripe Controller
    class StripeController < Api::V1::ApplicationController
      def stripe_webhooks
        Stripe::WebhookService.call(stripe_params)
        head :no_content
      end

      private

      def stripe_params
        params.permit!
      end
    end
  end
end
