# frozen_string_literal: true

module Api
  module V1
    # public Authentication Controller
    class AuthenticationController < Api::V1::ApplicationController
      def login
        token = Auth::LoginService.call(login_params)
        render json: { data: { token: token } }, status: :ok
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
