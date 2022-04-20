# frozen_string_literal: true

# Module Error Handler
module ErrorHandler
  def self.included(klass)
    klass.class_eval do
      rescue_from StandardError do |e|
        respond(:internal_server_error, :standard_error, e.to_s)
      end
      rescue_from ActiveRecord::RecordNotFound do |e|
        respond(:not_found, :record_not_found, e.to_s)
      end
      rescue_from ArgumentError do |e|
        respond(:unprocessable_entity, :argument_error, e.to_s)
      end
      rescue_from ActionDispatch::Http::Parameters::ParseError do |_e|
        respond(:bad_request)
      end
      rescue_from CustomError do |e|
        respond(e.status, e.error, e.message)
      end
    end
  end

  private

  def respond(status, error = nil, message = nil)
    json = Helpers::Render.json(error, message)
    json.nil? ? head(status) : render(json: json, status: status)
  end
end
