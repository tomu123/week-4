class Like < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :user,
            uniqueness: { scope: :product,
                          message: "#{user.first_name} #{user.last_name} has already marked #{product.name} as one of his favorites" }
end
