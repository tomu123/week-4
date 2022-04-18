# frozen_string_literal: true

module Auth
  # Authorize Request Service
  class AuthorizeRequestService < ApplicationService
    include ActionController::HttpAuthentication::Token::ControllerMethods

    attr_reader :request

    def initialize(request)
      super()
      @request = request
    end

    def call
      authenticate_or_request_with_http_token do |token, _options|
        @decoded_token = JsonWebToken.decode(token)
        find_user
      end
    rescue ActiveRecord::RecordNotFound => e
      # Handle expired token, e.g. logout user or deny access
      raise CustomError.new('Invalid Token', e.message, :unauthorized)
    end

    private

    def find_user
      User.find(@decoded_token[:user_id])
    end
  end
end
