# frozen_string_literal: true

module SwaggerBlocks
  # Product Schemas for SwaggerBlocks
  class Product < ActiveRecord::Base
    include Swagger::Blocks

    swagger_schema :Product do
      key :required, %i[id name description price stock]
      property :id do
        key :type, :integer
        key :format, :int64
      end
      property :name do
        key :type, :string
      end
      property :description do
        key :type, :string
      end
      property :price do
        key :type, :float
      end
      property :stock do
        key :type, :integer
        key :format, :int64
      end
    end

    # swagger_schema :ProductInput do
    #   allOf do
    #     schema do
    #       key :'$ref', :Product
    #     end
    #     schema do
    #       key :required, [:name]
    #       property :id do
    #         key :type, :integer
    #         key :format, :int64
    #       end
    #     end
    #   end
    # end

    # ...
  end
end
