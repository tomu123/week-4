# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :order_lines, dependent: :nullify
  has_many :orders, through: :order_lines
  has_many :customers, through: :orders
  has_many :likes, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :product_tags
  has_many :tags, through: :product_tags

  scope :sort_by_price, ->(desc) { order(price: desc) }
  scope :sort_by_name, ->(desc) { order(name: desc) }
  scope :sort_by_popularity, ->(desc) { left_outer_joins(:likes).group('products.id').order("COUNT(likes.id) #{desc}") }
  scope :sort_by_sales, ->(desc) { joins(:order_lines).group(:id).order("sum(order_lines.quantity) #{desc}") }

  scope :search_by_name, ->(name) { where('products.name ~* ?', "^.*#{name}.*$") }
  scope :search_by_tag, ->(tag) { joins(:tags).where('tags.id = ?', tag) }

  def liked?(user)
    likes.find_by(user: user).present?
  end
end
