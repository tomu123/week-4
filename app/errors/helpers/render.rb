# helper
module Helpers
  # class Render
  class Render
    def self.json(error, message)
      return nil if error.blank? && message.blank?

      result = { errors: {} }
      result[:errors][:title] = error unless error.blank?
      result[:errors][:detail] = message unless message.blank?
      result.as_json
    end
  end
end
