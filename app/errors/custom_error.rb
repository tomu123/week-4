# frozen_string_literal: true

# Class for custom errors
class CustomError < StandardError
  attr_reader :error, :message, :status

  def initialize(error = nil, message = nil, status = nil)
    super
    @error = error || 'base'
    @message = message || 'Something went wrong'
    @status = status || :unprocessable_entity
  end

  def fetch_json
    Helpers::Render.json(error, message)
  end
end
