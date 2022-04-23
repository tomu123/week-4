class Comment::CreateService < ApplicationService
  attr_reader :params, :current_user

  def initialize(current_user, params = {})
    super()
    @params = params
    @current_user = current_user
  end

  def call
    find_user
    comment_form = CommentForm.new(comment_params)
    validate(comment_form)
    create(comment_form.attributes)
    json = render_json
    [json, @comment]
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    {
      user_id: @current_user.id,
      date: Time.current,
      description: params[:data][:description],
      rating: params[:data][:rating]
    }
  end

  def validate(comment_form)
    error = :argument_error
    status = :unprocessable_entity
    raise CustomError.new(error: error, status: status, message: comment_form.errors.to_hash) unless comment_form.valid?
  end

  def create(comment_params)
    @comment = @user.comments.create(comment_params)
  end

  def render_json
    CommentRepresenter.jsonapi_new(@comment).to_json
  end
end
