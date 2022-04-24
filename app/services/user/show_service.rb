class User::ShowService < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    super()
    @user_id = user_id
  end

  def call
    find_user
    render_json
  end

  private

  def find_user
    @user = User.find(user_id)
  end

  def render_json
    UserRepresenter.jsonapi_new(@user).to_json
  end
end
