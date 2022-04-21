# frozen_string_literal: true

module Auth
  # Login Service
  class LoginService < ApplicationService
    attr_reader :params

    def initialize(params = {})
      super()
      @params = params
    end

    def call
      find_user
      validate
      create_jwt
      render_json
    end

    private

    def find_user
      @user = User.find_by(email: params[:email])
    end

    def validate
      unless @user&.valid_password?(params[:password])
        raise CustomError.new('Login error', 'Incorrect email or password',
                              :unauthorized)
      end
    end

    def create_jwt
      @token = JsonWebToken.encode(user_id: @user.id)
    end

    def render_json
      {
        "token": @token,
        "expires": 8.days.from_now,
        "user": {
          "first_name": @user.first_name,
          "last_name": @user.last_name
        }
      }.to_json
    end
  end
end
