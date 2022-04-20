class SearchService < ApplicationService
  include Pagy::Backend

  private

  def render_json(representer, collection, pagy)
    response = representer.jsonapi_for_collection(collection)
    response[:meta] = {
      'Current-Page' => pagy.page,
      'Page-Items' => pagy.items,
      'Total-Pages' => pagy.pages,
      'Total-Count' => pagy.count
    }
    response.to_json
  end
end
