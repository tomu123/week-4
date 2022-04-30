# frozen_string_literal: true

class StripeTransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @stripe_transactions = current_user.admin_role? ? StripeTransaction.all : current_user.stripe_transactions
  end
end
