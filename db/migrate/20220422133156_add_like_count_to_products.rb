class AddLikeCountToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :like_count, :integer
  end
end
