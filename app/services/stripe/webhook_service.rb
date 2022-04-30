# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation
class Stripe::WebhookService < ApplicationService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    case params[:type]
    when 'charge.succeeded'
      SuccessfullPurchaseJob.perform_later(params)
    when 'charge.failed'
      FailedPurchaseJob.perform_later(params)
    end
  end
end
