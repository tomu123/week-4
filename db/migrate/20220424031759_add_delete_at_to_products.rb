class AddDeleteAtToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :delete_at, :date
  end
end
