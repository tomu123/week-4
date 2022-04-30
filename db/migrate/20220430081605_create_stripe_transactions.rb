class CreateStripeTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_transactions do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2
      t.string :card_country
      t.string :currency
      t.string :status
      t.string :card_brand
      t.string :card_funding
      t.string :network

      t.timestamps
    end
  end
end
