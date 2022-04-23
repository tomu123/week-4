class AddCommentStatusToComments < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE comment_status AS ENUM ('pending', 'approved');
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TYPE comment_status;
        SQL
      end
    end
    add_column :comments, :comment_status, :comment_status, default: 'pending'
    add_index :comments, :comment_status
  end
end
