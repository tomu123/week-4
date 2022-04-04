class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.string :description
      t.integer :rating
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
