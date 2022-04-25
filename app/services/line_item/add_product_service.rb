class LineItem::AddProductService < ApplicationService
  attr_reader :params, :current_user

  def initialize(current_user, params = {})
    super()
    @params = params
    @current_user = current_user
  end

  def call
    find_cart
    find_product
    line_item_form = LineForm.new(quantity: params[:quantity])
    validate(line_item_form)
    find_line_item
    add_quantity
    save
  end

  private

  def find_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def validate(form)
    error = :argument_error
    status = :unprocessable_entity
    raise CustomError.new(error: error, status: status, message: form.errors.to_hash) unless form.valid?
  end

  def find_line_item
    @line_item = LineItem.find_or_initialize_by(product: @product, cart: @cart)
  end

  def add_quantity
    @line_item.quantity ||= 0
    @line_item.quantity += params[:quantity]
  end

  def save
    @line_item.save!
  end
end
