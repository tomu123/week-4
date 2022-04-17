# frozen_string_literal: true

# Service to like a product
class Like::CreateService < ApplicationService
  attr_reader :params
  attr_accessor :result

  def initialize(params = {})
    super()
    @params = params
  end

  def call
    like_form = Like::CreateForm.new(params)
    validate(like_form)
    create(like_form.attributes)
  end

  private

  def validate(like_form)
    raise ArgumentError, like_form.errors.as_json unless like_form.valid?
  end

  def create(like_params)
    Like.create(like_params)
  end
end
