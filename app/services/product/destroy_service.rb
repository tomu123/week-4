class Product::DestroyService < ApplicationService
  attr_reader :product_id

  def initialize(product_id)
    super()
    @product_id = product_id
  end

  def call
    find_product
    destroy
  end

  private

  def destroy
    @product.destroy
    @product
  end

  def find_product
    @product = Product.find(@product_id)
  end
end
