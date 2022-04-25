# frozen_string_literal: true

require 'test_helper'

class Api::V1::Customer::LikesControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test 'update like_count job scheduling' do
    product = create(:product)
    customer = create(:user)
    assert_enqueued_with(job: UpdateLikeCountJob) do
      Like::CreateService.call(product.id, customer)
    end
  end
end
