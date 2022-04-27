class User::RecoverService < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    super()
    @user_id = user_id
  end

  def call
    find_user
    recover
    render_json
  end

  private

  def find_user
    @user = User.unscoped.find(@user_id)
  end

  def recover
    @user.recover
  end

  def render_json
    UserRepresenter.jsonapi_new(@user).to_json
  end
end
