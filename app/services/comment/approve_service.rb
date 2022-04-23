# frozen_string_literal: true

# Service to delete a comment
class Comment::ApproveService < ApplicationService
  attr_reader :comment_id

  def initialize(comment_id)
    super()
    @comment_id = comment_id
  end

  def call
    find_comment
    approve
  end

  private

  def find_comment
    @comment = Comment.unscoped.find(@comment_id)
  end

  def approve
    @comment.approved_status!
  end
end
