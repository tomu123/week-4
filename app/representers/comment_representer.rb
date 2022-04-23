class CommentRepresenter < ApplicationRepresenter
  property :id
  property :user, as: :author do
    property :id
    property :name
  end
  property :date
  property :description
  property :rating
  property :commentable_type
  property :commentable_id
  property :comment_status
end
