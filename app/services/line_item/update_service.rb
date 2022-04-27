# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
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
    render_json
  end

  private

  def find_cart
    @cart = Cart.find_by(user: current_user)
    raise CustomError.new(error: 'Cart Empty', status: :unprocessable_entity) if @cart.blank? || @cart.line_items.empty?
  end

  def validate(form)
    unless form.valid?
      raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: form.errors.to_hash)
    end
  end

  def find_line_item
    @line_item = @cart.line_items.find(line_item_id)
  end

  def update
    @line_item.update(quantity: params[:quantity])
  end

  def render_json
    LineItemRepresenter.jsonapi_new(@line_item).to_json
  end
end
