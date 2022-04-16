# helper
module Helpers
  # class Render
  class Render
    def self.json(error, message)
      {
        errors:
        {
          field_name: error,
          message: message
        }
      }.as_json
    end
  end
end
