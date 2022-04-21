class SearchService < ApplicationService
  include Pagy::Backend

  private

  def render_json(representer, collection, pagy)
    response = representer.jsonapi_for_collection(collection)
    response[:meta] = {
      'current_page' => pagy.page,
      'page_items' => pagy.items,
      'total_pages' => pagy.pages,
      'total_count' => pagy.count
    }
    response.to_json
  end
end
