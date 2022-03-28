class Product < ApplicationRecord
  validates :name, :price, :stock, presence: { message: '%{attribute} must always be specified for %{model}' }
  has_many :order_lines
  has_many :orders, through: :order_lines
  has_many :customers, through: :orders
  scope :sort_by_price, ->(desc) { desc ? unscoped.order(price: :desc) : unscoped.order(:price) }
  scope :sort_by_sales, -> { unscoped.joins(:order_lines).group(:id).order('sum(order_lines.quantity) desc') }
  scope :search_by_name, ->(search_key) { where("name ~ \'^.*?.*$\'", search_key) }
  default_scope { order(:name) }
end
