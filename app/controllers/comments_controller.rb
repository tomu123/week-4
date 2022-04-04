class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :belong_to_user!, only: %i[edit destroy update]
  after_action :redirect_to_commentable!, only: %i[edit destroy update]

  def create
    params[:comment][:user_id] = current_user.id
    params[:comment][:date] = Time.now
    Comment.create(comment_params)
  end

  def edit; end

  def update
    params[:comment][:date] = Time.now
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :rating, :description, :date)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def belong_to_user!
    redirect_to_commentable! if @comment.user != current_user
  end

  def redirect_to_commentable!
    redirect_to @comment.commentable
  end
end
