# frozen_string_literal: true

# Service to unlike a product
class Like::DestroyService < ApplicationService
  attr_reader :params
  attr_accessor :result

  def initialize(params = {})
    super()
    @params = params
    @result = {}
  end

  def call
    like_form = Like::DestroyForm.new(params)
    validate(like_form)
    destroy(like_form.attributes)
  end

  private

  def validate(like_form)
    raise ArgumentError, like_form.errors.as_json unless like_form.valid?
  end

  def destroy(like_params)
    Like.delete_by(like_params)
  end
end
