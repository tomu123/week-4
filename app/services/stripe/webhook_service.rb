# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation
class Stripe::WebhookService < ApplicationService
  attr_reader :signature, :payload

  def initialize(signature = nil, payload = nil)
    super()
    @signature = signature
    @payload = payload
  end

  def call
    raise CustomError.new(status: :bad_request) unless signature.present? || payload.present?

    begin
      event = Stripe::Webhook.construct_event(
        payload, signature, ENV['STRIPE_ENDPOINT_SECRET']
      )
    rescue JSON::ParserError
      # Invalid payload
      raise CustomError.new(status: :bad_request)
    rescue Stripe::SignatureVerificationError
      # Invalid signature
      raise CustomError.new(status: :bad_request)
    end

    case event.type
    when 'charge.succeeded'
      SuccessfullPurchaseJob.perform_later(event.to_hash)
    when 'charge.failed'
      FailedPurchaseJob.perform_later(event.to_hash)
    end
  end
end
