class Product::UpdateService < ApplicationService
  attr_reader :params
  attr_accessor :result

  def initialize(product_id, params = {})
    super()
    @product_id = product_id
    @params = params
    @result = {}
  end

  def call
    find_product
    product_form = ProductForm.new(product_params)
    validate(product_form)
    update(product_form.attributes) if @result[:errors].blank?
    @result
  end

  private

  def validate(product_form)
    @result[:errors] = product_form.errors unless product_form.valid?
  end

  def update(product_params)
    @product.update(product_params)
    @result[:success] = @product
  end

  def find_product
    @product = Product.find(@product_id)
  end

  def product_params
    @product.attributes.merge(@params).symbolize_keys.slice(:name, :description, :price, :stock)
  end
end
