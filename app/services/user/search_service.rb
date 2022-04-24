class User::SearchService < SearchService
  attr_reader :params

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    users = User.unscoped
    pagy, users = PaginationService.call(params, users)
    render_json(UserRepresenter, users, pagy)
  end
end
