class Cart::ShowService < ApplicationService
  attr_reader :current_user

  def initialize(current_user)
    super()
    @current_user = current_user
  end

  def call
    find_cart
    render_json
  end

  private

  def find_cart
    @cart = Cart.includes(:user, line_items: :product).find_or_create_by!(user: current_user)
  end

  def render_json
    CartRepresenter.jsonapi_new(@cart).to_json
  end
end
