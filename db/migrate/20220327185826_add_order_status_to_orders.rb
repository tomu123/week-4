class AddOrderStatusToOrders < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE order_status AS ENUM ('pending', 'completed', 'cancelled');
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TYPE order_status;
        SQL
      end
    end
    add_column :orders, :order_status, :order_status, default: 'pending'
    add_index :orders, :order_status
  end
end
