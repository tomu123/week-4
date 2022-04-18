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
      user = find_user
      validate(user)
      create_jwt(user)
    end

    private

    def find_user
      User.find_by(email: params[:email])
    end

    def validate(user)
      unless user&.valid_password?(params[:password])
        raise CustomError.new('Login error', 'Incorrect email or password',
                              :unauthorized)
      end
    end

    def create_jwt(user)
      JsonWebToken.encode(user_id: user.id)
    end
  end
end
