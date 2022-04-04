# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :product_tags, dependent: :destroy
  has_many :products, through: :product_tags

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
