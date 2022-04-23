class Comment::SearchService < SearchService
  attr_reader :params, :current_user

  def initialize(current_user, params = {})
    super()
    @params = params
    @current_user = current_user
  end

  def call
    comments = current_user.admin_role? ? Comment.unscoped : Comment.all
    comments = FilteredCommentsQuery.new(params, comments).call
    pagy, comments = PaginationService.call(params, comments)
    render_json(CommentRepresenter, comments, pagy)
  end
end
