# frozen_string_literal: true

module Api
  module V1
    module Admin
      class ApplicationController < Api::V1::ApplicationController
        before_action :authorize_request, :authorize_role

        private

        def authorize_role
          message = "Current User: #{@current_user.name} is not an admin."
          raise CustomError.new('Invalid User', message, :unauthorized) unless @current_user.admin_role?
        end
      end
    end
  end
end
