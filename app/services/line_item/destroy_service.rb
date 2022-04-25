# frozen_string_literal: true

# Service to delete a line_item
class LineItem::DestroyService < ApplicationService
  attr_reader :line_item_id, :current_user

  def initialize(current_user, line_item_id)
    super()
    @line_item_id = line_item_id
    @current_user = current_user
  end

  def call
    find_cart
    find_line_item
    destroy
  end

  private

  def find_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end

  def find_line_item
    @line_item = @cart.line_items.find(line_item_id)
  end

  def destroy
    @line_item.destroy
  end
end
