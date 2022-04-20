# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include ActionController::HttpAuthentication::Token
      include ErrorHandler

      def authorize_request
        token, options = token_and_options(request)
        @current_user = Auth::AuthorizeRequestService.call(token, options)
      end
    end
  end
end
