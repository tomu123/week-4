# frozen_string_literal: true

module Auth
  # Authorize Request Service
  class AuthorizeRequestService < ApplicationService
    attr_reader :token, :options

    def initialize(token, options)
      super()
      @token = token
      @options = options
    end

    def call
      @decoded_token = JsonWebToken.decode(token)
      find_user
    end

    private

    def find_user
      User.find(@decoded_token[:user_id])
    rescue ActiveRecord::RecordNotFound
      # Handle expired token, e.g. logout user or deny access
      raise CustomError.new(status: :unauthorized)
    end
  end
end
