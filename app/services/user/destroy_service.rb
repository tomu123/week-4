class User::DestroyService < ApplicationService
  attr_reader :user_id

  def initialize(user_id)
    super()
    @user_id = user_id
  end

  def call
    find_user
    destroy
  end

  private

  def find_user
    @user = User.find(@user_id)
  end

  def destroy
    @user.destroy
  end
end
