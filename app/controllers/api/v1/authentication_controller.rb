# frozen_string_literal: true

module Api
  module V1
    # public Authentication Controller
    class AuthenticationController < Api::V1::ApplicationController
      def login
        json = Auth::LoginService.call(login_params)
        render json: json, status: :ok
      end

      private

      def login_params
        params.require(:data).require(:attributes).permit(:email, :password)
      end
    end
  end
end
