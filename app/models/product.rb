class Product < ApplicationRecord
  validates :name, :price, :stock, presence: { message: '%{attribute} must always be specified for %{model}' }
  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true }
  has_many :order_lines, dependent: :nullify
  has_many :orders, through: :order_lines
  has_many :customers, through: :orders
  has_many :likes
  scope :sort_by_price, ->(desc) { desc ? unscoped.order(price: :desc) : unscoped.order(:price) }
  scope :sort_by_sales, -> { unscoped.joins(:order_lines).group(:id).order('sum(order_lines.quantity) desc') }
  scope :search_by_name, ->(search_key) { where('name ~* ?', "^.*#{search_key}.*$") }
  default_scope { order(:name) }
end
