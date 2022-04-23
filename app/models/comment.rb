# frozen_string_literal: true

class Comment < ApplicationRecord
  enum comment_status: { pending: 'pending', approved: 'approved' }, _suffix: 'status', _default: 'pending'
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  default_scope { approved_status }
end
