# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :belong_to_user!, only: %i[edit destroy update]

  def create
    params[:comment][:user_id] = current_user.id
    params[:comment][:date] = Time.now
    @comment = Comment.new(comment_params)
    @comment.commentable_type = params[:commentable_type]
    @comment.commentable_id = params[:product_id] if params[:commentable_type] == 'Product'
    @comment.commentable_id = params[:order_id] if params[:commentable_type] == 'Order'
    if @comment.save
      flash[:notice] = 'Your comment has been published'
    else
      flash[:alert] = @comment.errors.full_messages
    end
    redirect_to @comment.commentable and return
  end

  def edit; end

  def update
    params[:comment][:date] = Time.now
    @comment.update(comment_params)
    redirect_to @comment.commentable
  end

  def destroy
    @comment.destroy
    redirect_to @comment.commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :rating, :description, :date)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def belong_to_user!
    redirect_to @comment.commentable if @comment.user != current_user
  end
end
