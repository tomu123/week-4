class Order < ApplicationRecord
  enum order_status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }, _prefix: true, _default: 'pending'
  belongs_to :user
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines
end
