class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :address, presence: true
  has_many :orders
  has_many :order_lines, through: :orders
  has_many :products, through: :order_lines
  has_many :likes
  scope :orders_between_dates, ->(id, date_range) { find(id).orders.where(date: date_range) }

  def name
    "#{first_name} #{last_name}"
  end
end
