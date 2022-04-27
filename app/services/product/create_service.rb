# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
class Product::CreateService < ApplicationService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    product_form = ProductForm.new(params)
    validate(product_form)
    create(product_form.attributes)
    json = render_json
    [json, @product]
  end

  private

  def validate(product_form)
    unless product_form.valid?
      raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: product_form.errors.to_hash)
    end
  end

  def create(product_params)
    @product = Product.create(product_params)
  end

  def render_json
    ProductRepresenter.jsonapi_new(@product).to_json
  end
end
