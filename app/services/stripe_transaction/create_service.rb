# rubocop:disable Style/ClassAndModuleChildren,Style/Documentation
class StripeTransaction::CreateService < ApplicationService
  attr_reader :cart, :event

  def initialize(cart, event = {})
    super()
    @cart = cart
    @event = event
  end

  def call
    find_cart
    stripe_transaction_attributes
    create_stripe_transaction
  end

  private

  def find_cart
    @cart = Cart.includes(line_items: :product).find(@cart.id)
  end

  def stripe_transaction_attributes
    @attributes = {
      date: Time.current,
      user: cart.user,
      amount: event.dig(:data, :object, :amount),
      card_country: event.dig(:data, :object, :payment_method_details, :card, :country),
      currency: event.dig(:data, :object, :currency),
      status: event.dig(:data, :object, :status),
      card_brand: event.dig(:data, :object, :payment_method_details, :card, :brand),
      card_funding: event.dig(:data, :object, :payment_method_details, :card, :funding),
      network: event.dig(:data, :object, :payment_method_details, :card, :network),
      stripe_transaction_lines_attributes: LineDataRepresenter.for_collection.new(cart.line_items).to_hash
    }
  end

  def create_stripe_transaction
    StripeTransaction.create(@attributes)
  end
end
