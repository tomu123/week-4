class LikeRepresenter < ApplicationRepresenter
  property :user do
    property :id
    property :name
  end
  property :product do
    property :id
    property :name
  end
end
