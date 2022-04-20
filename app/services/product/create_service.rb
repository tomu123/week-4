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
    error = :argument_error
    status = :unprocessable_entity
    raise CustomError.new(error: error, status: status, message: product_form.errors.to_hash) unless product_form.valid?
  end

  def create(product_params)
    @product = Product.create(product_params)
  end

  def render_json
    ProductRepresenter.jsonapi_new(@product).to_json
  end
end
