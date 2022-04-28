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
    create_order
    @order = Order.includes(order_lines: { product: { likes: :user } }).find(@order.id)
    stock_notification
    @cart.destroy
    json = render_json
    [json, @order]
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

  def create_order
    @order = Order.create(@attributes)
  end

  def stock_notification
    @order.order_lines.each do |ol|
      stock = ol.product.stock
      user = ol.product.likes.unscope(:order).last&.user
      next if user.blank?

      product_id = ol.product_id
      ProductMailer.with(product_id: product_id, recipient_id: user.id).stock_notification.deliver_later if stock <= 3
    end
  end

  def render_json
    OrderRepresenter.jsonapi_new(@order).to_json
  end
end
