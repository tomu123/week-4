# frozen_string_literal: true

class OrderLine < ApplicationRecord
  after_commit :update_stock, on: :create

  belongs_to :order
  belongs_to :product

  private

  def update_stock
    product.stock -= quantity
    product.save
  end
end
