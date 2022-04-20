# frozen_string_literal: true

# Class for custom errors
class CustomError < StandardError
  attr_reader :error, :message, :status

  def initialize(error_params = {})
    super
    @error = error_params[:error]
    @message = error_params[:message]
    @status = error_params[:status]
  end

  def fetch_json
    Helpers::Render.json(error, message)
  end
end
