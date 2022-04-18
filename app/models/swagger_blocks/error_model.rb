# frozen_string_literal: true

module SwaggerBlocks
  # ErrorModel Class for SwaggerBlocks
  class ErrorModel
    include Swagger::Blocks

    swagger_schema :ErrorModel do
      key :required, %i[code message]
      property :code do
        key :type, :integer
        key :format, :int32
      end
      property :message do
        key :type, :string
      end
    end
  end
end
