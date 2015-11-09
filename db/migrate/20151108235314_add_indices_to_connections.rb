class AddIndicesToConnections < ActiveRecord::Migration
  def up
    add_index :connections, [:user_id, :friend_id], unique: true
  end

  def down
    remove_index :connections, [:user_id, :friend_id]
  end
end
