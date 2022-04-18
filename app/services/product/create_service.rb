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
  end

  private

  def validate(product_form)
    raise ArgumentError, product_form.errors.as_json unless product_form.valid?
  end

  def create(product_params)
    Product.create(product_params)
  end
end
