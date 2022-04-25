class SetDefaultLikeCountToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:products, :like_count, 0)
  end
end
