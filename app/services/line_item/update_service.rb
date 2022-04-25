class LineItem::UpdateService < ApplicationService
  attr_reader :params, :line_item_id, :current_user

  def initialize(current_user, line_item_id, params = {})
    super()
    @params = params
    @line_item_id = line_item_id
    @current_user = current_user
  end

  def call
    find_cart
    line_item_form = LineForm.new(quantity: params[:quantity])
    validate(line_item_form)
    find_line_item
    update
  end

  private

  def find_cart
    @cart = Cart.find_or_create_by!(user: current_user)
  end

  def validate(form)
    error = :argument_error
    status = :unprocessable_entity
    raise CustomError.new(error: error, status: status, message: form.errors.to_hash) unless form.valid?
  end

  def find_line_item
    @line_item = @cart.line_items.find(line_item_id)
  end

  def update
    @line_item.update(quantity: params[:quantity])
  end
end
