class CommentForm
  include ActiveModel::Model

  attr_accessor :user_id, :date, :description, :rating

  validates :user_id, :date, :description, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5, message: '%{attribute} should be between 1 and 5' }

  def attributes
    {
      user_id: user_id,
      date: date,
      description: description,
      rating: rating,
      comment_status: 'pending'
    }
  end
end
