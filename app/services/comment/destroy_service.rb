# frozen_string_literal: true

# Service to delete a comment
class Comment::DestroyService < ApplicationService
  attr_reader :comment_id

  def initialize(comment_id)
    super()
    @comment_id = comment_id
  end

  def call
    find_comment
    destroy
  end

  private

  def find_comment
    @comment = Comment.unscoped.find(@comment_id)
  end

  def destroy
    @comment.destroy
  end
end
