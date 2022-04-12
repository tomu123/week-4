class Product::CreateService < ApplicationService
  attr_reader :params
  attr_accessor :result

  def initialize(params = {})
    super()
    @params = params
    @result = {}
  end

  def call
    product_form = ProductForm.new(params)
    validate(product_form)
    create(product_form.attributes) if @result[:errors].blank?
    @result
  end

  private

  def validate(product_form)
    @result[:errors] = product_form.errors unless product_form.valid?
  end

  def create(product_params)
    @result[:success] = Product.create(product_params)
  end
end
