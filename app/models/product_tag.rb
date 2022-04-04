# frozen_string_literal: true

class ProductTag < ApplicationRecord
  belongs_to :product
  belongs_to :tag
  validates :tag, :product, presence: true
  validates :tag, uniqueness: { scope: :product, message: lambda do |object, _data|
                                                            "#{object.tag.name} tag already exists for this product #{object.product.name}"
                                                          end }
end
