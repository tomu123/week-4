# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation,Style/GuardClause
class User::CreateService < ApplicationService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    validate_user_role if params[:user_role].present?
    @user = User.new(params)
    validate
    @user.save
    json = render_json
    [json, @user]
  end

  private

  def validate_user_role
    message = "Invalid User Role : #{params[:user_role]}"
    raise ArgumentError, message unless %w[support customer].include?(params[:user_role])
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
