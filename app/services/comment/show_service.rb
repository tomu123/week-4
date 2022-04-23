class Comment::ShowService < ApplicationService
  attr_reader :comment_id, :admin

  def initialize(comment_id, admin)
    super()
    @comment_id = comment_id
    @admin = admin
  end

  def call
    find_comment
    render_json
  end

  private

  def find_comment
    @comment = admin ? Comment.unscoped.find(comment_id) : Comment.find(comment_id)
  end

  def render_json
    CommentRepresenter.jsonapi_new(@comment).to_json
  end
end
