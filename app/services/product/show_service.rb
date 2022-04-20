class Product::ShowService < ApplicationService
  attr_reader :product_id

  def initialize(product_id)
    super()
    @product_id = product_id
  end

  def call
    find_product
    render_json
  end

  private

  def find_product
    @product = Product.find(product_id)
  end

  def render_json
    ProductRepresenter.jsonapi_new(@product).to_json
  end
end
