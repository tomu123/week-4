class LikeRepresenter < ApplicationRepresenter
  property :user do
    property :id
    property :name
  end
  property :product do
    property :id
    property :name
    property :like_count
  end
end
