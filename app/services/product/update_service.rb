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
  end

  private

  def validate(product_form)
    raise ArgumentError, product_form.errors.as_json unless product_form.valid?
  end

  def update(product_params)
    @product.update(product_params)
    @product
  end

  def find_product
    @product = Product.find(@product_id)
  end

  def product_params
    @product.attributes.merge(@params).symbolize_keys.slice(:name, :description, :price, :stock)
  end
end
