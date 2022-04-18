# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include ErrorHandler

      def authorize_request
        @current_user = Auth::AuthorizeRequestService.call(request)
      end
    end
  end
end
