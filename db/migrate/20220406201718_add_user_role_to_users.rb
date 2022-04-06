class AddUserRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE user_role AS ENUM ('customer', 'admin', 'support');
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TYPE user_role;
        SQL
      end
    end
    add_column :users, :user_role, :user_role, default: 'customer'
    add_index :users, :user_role
  end
end
