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

  def find_product
    @product = Product.find(@product_id)
  end

  def destroy
    @product.soft_destroy
  end
end
