class Product < ApplicationRecord
  validates :name, :price, :stock, presence: { message: '%{attribute} must always be specified for %{model}' }
  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true }

  has_many :order_lines, dependent: :nullify
  has_many :orders, through: :order_lines
  has_many :customers, through: :orders
  has_many :likes
  has_many :comments, as: :commentable
  has_many :product_tags
  has_many :tags, through: :product_tags

  scope :sort_by_price, ->(desc) { desc ? order(price: :desc) : order(:price) }
  scope :sort_by_name, ->(desc) { desc ? order(name: :desc) : order(:name) }
  scope :sort_by_popularity, lambda { |desc|
                               desc ? left_outer_joins(:likes).group('products.id').order('COUNT(likes.id) DESC') : left_outer_joins(:likes).group('products.id').order('COUNT(likes.id)')
                             }
  scope :sort_by_sales, -> { joins(:order_lines).group(:id).order('sum(order_lines.quantity) desc') }
  scope :search_by_name, ->(search_key) { where('name ~* ?', "^.*#{search_key}.*$") }
  default_scope { sort_by_name(false) }

  def liked?(user)
    likes.find_by(user: user).present?
  end
end
