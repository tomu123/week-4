class CreateOrderLines < ActiveRecord::Migration[6.1]
  def change
    create_table :order_lines do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2

      t.timestamps
    end
  end
end
