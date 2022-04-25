require 'test_helper'

class UpdateLikeCountJobTest < ActiveJob::TestCase
  test 'that like count is updated' do
    product = create(:product)
    assert_difference('product.like_count') do
      UpdateLikeCountJob.perform_now(product.id, 1)
      product.reload
    end
  end
end
