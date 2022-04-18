# frozen_string_literal: true

module Api
  module V1
    module SwaggerBlocks
      # Swagger Products Controller
      class ProductsController < ActionController::Base
        include Swagger::Blocks

        swagger_path '/api/v1/products/{id}' do
          operation :get do
            key :summary, 'Find Product by ID'
            key :description, 'Returns a single product'
            key :operationId, 'findProductById'
            key :tags, [
              'product'
            ]
            parameter do
              key :name, :id
              key :in, :path
              key :description, 'ID of product to fetch'
              key :required, true
              key :type, :integer
              key :format, :int64
            end
            response 200 do
              key :description, 'product response'
              schema do
                key :'$ref', '../../../models/swagger_blocks/product'
              end
            end
            response :default do
              key :description, 'unexpected error'
              schema do
                key :'$ref', '../../../models/swagger_blocks/error_model'
              end
            end
          end
        end
        swagger_path '/api/v1/products' do
          operation :get do
            key :summary, 'Index Products'
            key :description, 'Returns all products from the system according to filtering and sorting parameters'
            key :operationId, 'indexProducts'
            key :produces, [
              'application/json',
              'text/html'
            ]
            key :tags, [
              'product'
            ]
            parameter do
              key :name, :sort_by_name
              key :in, :query
              key :description, 'direction to sort by name'
              key :required, false
              key :type, :string
              key :enum, %w[asc desc]
            end
            parameter do
              key :name, :sort_by_price
              key :in, :query
              key :description, 'direction to sort by price'
              key :required, false
              key :type, :string
              key :enum, %w[asc desc]
            end
            parameter do
              key :name, :sort_by_popularity
              key :in, :query
              key :description, 'direction to sort by popularity'
              key :required, false
              key :type, :string
              key :enum, %w[asc desc]
            end
            parameter do
              key :name, :sort_by_sales
              key :in, :query
              key :description, 'direction to sort by sales'
              key :required, false
              key :type, :string
              key :enum, %w[asc desc]
            end
            parameter do
              key :name, :items
              key :in, :query
              key :description, 'maximum number of results to return per page'
              key :required, false
              key :type, :integer
              key :format, :int32
            end
            parameter do
              key :name, :page
              key :in, :query
              key :description, 'page number to return'
              key :required, false
              key :type, :integer
              key :format, :int32
            end
            parameter do
              key :name, :name
              key :in, :query
              key :description, 'search keywords to filter by'
              key :required, false
              key :type, :string
            end
            parameter do
              key :name, :tag
              key :in, :query
              key :description, 'tag to filter by'
              key :required, false
              key :type, :string
            end
            response 200 do
              key :description, 'product response'
              schema do
                key :type, :array
                items do
                  key :'$ref', '../../../models/swagger_blocks/product'
                end
              end
            end
            response :default do
              key :description, 'unexpected error'
              schema do
                key :'$ref', '../../../models/swagger_blocks/error_model'
              end
            end
          end
          # operation :post do
          #   key :description, 'Creates a new pet in the store.  Duplicates are allowed'
          #   key :operationId, 'addPet'
          #   key :produces, [
          #     'application/json'
          #   ]
          #   key :tags, [
          #     'pet'
          #   ]
          #   parameter do
          #     key :name, :pet
          #     key :in, :body
          #     key :description, 'Pet to add to the store'
          #     key :required, true
          #     schema do
          #       key :'$ref', :PetInput
          #     end
          #   end
          #   response 200 do
          #     key :description, 'pet response'
          #     schema do
          #       key :'$ref', :Pet
          #     end
          #   end
          #   response :default do
          #     key :description, 'unexpected error'
          #     schema do
          #       key :'$ref', :ErrorModel
          #     end
          #   end
          # end
        end
      end
    end
  end
end
