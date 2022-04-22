class ProductRepresenter < ApplicationRepresenter
  property :id
  property :name
  property :description
  property :price
  property :stock
  property :image, exec_context: :decorator
  property :like_count

  def image
    return nil unless represented.image.attached?

    Rails.application.routes.url_helpers.url_for(represented.image.variant(resize_to_limit: [220, 220]))
  end
end
