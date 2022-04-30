class CreateStripeTransactionLines < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_transaction_lines do |t|
      t.references :stripe_transaction, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2

      t.timestamps
    end
  end
end
