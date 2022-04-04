class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :belong_to_user!, only: %i[edit destroy update]

  def create
    params[:comment][:user_id] = current_user.id
    params[:comment][:date] = Time.now
    Comment.create(comment_params)
    redirect_to product_path(params[:product_id])
  end

  def edit; end

  def update
    params[:comment][:date] = Time.now
    @comment.update(comment_params)
    redirect_to product_path(params[:product_id])
  end

  def destroy
    @comment.destroy
    redirect_to product_path(params[:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :rating, :description, :date)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def belong_to_user!
    redirect_to product_path(params[:product_id]) if @comment.user != current_user
  end
end
