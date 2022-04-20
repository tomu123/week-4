class Product::UpdateService < ApplicationService
  attr_reader :params, :product_id

  def initialize(product_id, params = {})
    super()
    @product_id = product_id
    @params = params
  end

  def call
    find_product
    product_form = ProductForm.new(product_params)
    validate(product_form)
    update(product_form.attributes)
    render_json
  end

  private

  def find_product
    @product = Product.find(@product_id)
  end

  def product_params
    @product.attributes.merge(@params).symbolize_keys.slice(:name, :description, :price, :stock)
  end

  def validate(product_form)
    error = :argument_error
    status = :unprocessable_entity
    raise CustomError.new(error: error, status: status, message: product_form.errors.to_hash) unless product_form.valid?
  end

  def update(product_params)
    @product.update(product_params)
  end

  def render_json
    ProductRepresenter.jsonapi_new(@product).to_json
  end
end
