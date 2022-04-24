class User::RecoverService < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    super()
    @user_id = user_id
  end

  def call
    find_user
    recover
  end

  private

  def find_user
    @user = User.unscoped.find(@user_id)
  end

  def recover
    @user.recover
  end
end
