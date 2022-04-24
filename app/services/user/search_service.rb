class User::SearchService < SearchService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    users = params[:filter].present? ? User.filter(params[:filter]) : User.all
    pagy, users = PaginationService.call(params, users)
    render_json(UserRepresenter, users, pagy)
  end
end
