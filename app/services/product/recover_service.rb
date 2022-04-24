class Product::RecoverService < ApplicationService
  attr_reader :product_id

  def initialize(product_id)
    super()
    @product_id = product_id
  end

  def call
    find_product
    recover
  end

  private

  def find_product
    @product = Product.unscoped.find(@product_id)
  end

  def recover
    @product.recover
  end
end
