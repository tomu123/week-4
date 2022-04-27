# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
class User::UpdateService < ApplicationService
  attr_reader :params, :user_id

  def initialize(user_id, params = {})
    super()
    @user_id = user_id
    @params = params
  end

  def call
    validate_user_role if params[:user_role].present?
    find_user
    @user.assign_attributes(params)
    validate
    @user.save
    render_json
  end

  private

  def validate_user_role
    message = "Invalid User Role : #{params[:user_role]}"
    raise ArgumentError, message unless %w[support customer].include?(params[:user_role])
  end

  def find_user
    @user = User.find(@user_id)
  end

  def validate
    unless @user.valid?
      raise CustomError.new(error: :argument_error, status: :unprocessable_entity, message: @user.errors.to_hash)
    end
  end

  def render_json
    UserRepresenter.jsonapi_new(@user).to_json
  end
end
