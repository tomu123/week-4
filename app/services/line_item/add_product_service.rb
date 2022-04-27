# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
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
    render_json
  end

  private

  def find_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end

  def find_product
    @product = Product.find(params[:product_id])
  end

  def validate(form)
    unless form.valid?
      raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: form.errors.to_hash)
    end
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

  def render_json
    LineItemRepresenter.jsonapi_new(@line_item).to_json
  end
end
