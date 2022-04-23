class FilteredCommentsQuery
  attr_reader :params, :relation

  STATUS_OPTIONS = Comment.comment_statuses.values

  def initialize(params = {}, relation = Comment.all)
    @params = params
    @relation = relation
  end

  def call
    search_by_status(params[:status]) if params[:status].present?
    search_by_user(params[:user_id]) if params[:user_id].present?
    @relation
  end

  def search_by_status(status)
    message = "Invalid status: #{status}"
    raise ArgumentError, message unless STATUS_OPTIONS.include?(status)

    @relation = @relation.public_send("#{status}_status")
  end

  def search_by_user(id)
    user = User.find(id)
    @relation = @relation.where(commentable: user)
  end
end
