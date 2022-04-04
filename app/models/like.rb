class Like < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user,
            uniqueness: { scope: :product,
                          message: lambda do |object, _data|
                            "#{object.user.name} has already marked #{object.product.name} as one of his favorites"
                          end }
end
