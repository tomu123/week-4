# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
class Cart::CheckoutService < ApplicationService
  attr_reader :current_user

  def initialize(current_user)
    super()
    @current_user = current_user
  end

  def call
    find_cart
    cart_to_order_attributes
    order_form = OrderForm.new(@attributes)
    validate(order_form)
    session_data
  end

  private

  def find_cart
    @cart = Cart.includes(line_items: :product).find_by(user: current_user)
    raise CustomError.new(error: 'Cart Empty', status: :unprocessable_entity) if @cart.blank? || @cart.line_items.empty?
  end

  def cart_to_order_attributes
    @attributes = CartToOrderRepresenter.new(@cart).to_hash
  end

  def validate(form)
    unless form.valid?
      raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: form.errors.to_hash)
    end
  end

  def session_data
    SessionDataRepresenter.new(@cart).to_hash
  end
end
