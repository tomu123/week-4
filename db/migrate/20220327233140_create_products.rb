# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :stock

      t.timestamps
    end
  end
end
