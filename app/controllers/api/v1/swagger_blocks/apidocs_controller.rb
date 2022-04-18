# frozen_string_literal: true

module Api
  module V1
    module SwaggerBlocks
      class ApidocsController < ActionController::Base
        include Swagger::Blocks

        swagger_root do
          key :swagger, '2.0'
          info do
            key :version, '1.0.0'
            key :title, 'ApplaudoStudios Ecommerce'
            key :description, 'A project created during the trainee program by Tomu Komatsu ' \
                              'at ApplaudoStudios in order to show his skills and learning progress'
            key :termsOfService, 'http://helloreverb.com/terms/'
            contact do
              key :name, 'Tomu Komatsu'
            end
            license do
              key :name, 'MIT'
            end
          end
          tag do
            key :name, 'product'
            key :description, 'Products operations'
            externalDocs do
              key :description, 'Find more info here'
              key :url, 'https://swagger.io'
            end
          end
          key :host, 'localhost'
          key :basePath, '/api/v1'
          key :consumes, ['application/json']
          key :produces, ['application/json']
        end

        # A list of all classes that have swagger_* declarations.
        SWAGGERED_CLASSES = [
          Api::V1::SwaggerBlocks::ProductsController,
          ::SwaggerBlocks::Product,
          ::SwaggerBlocks::ErrorModel,
          self
        ].freeze

        def index
          render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
        end
      end
    end
  end
end
