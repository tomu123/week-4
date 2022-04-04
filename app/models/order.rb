# frozen_string_literal: true

class Order < ApplicationRecord
  enum order_status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }, _prefix: true,
       _default: 'pending'
  belongs_to :user
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines
  has_many :comments, as: :commentable

  validates :user, :date, :order_status, presence: true
end
