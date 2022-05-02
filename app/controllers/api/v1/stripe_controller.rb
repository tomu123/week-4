# frozen_string_literal: true

module Api
  module V1
    # public Stripe Controller
    class StripeController < Api::V1::ApplicationController
      def stripe_webhooks
        Stripe::WebhookService.call(request.headers['Stripe-Signature'], request.body.read)
        head :no_content
      end
    end
  end
end
