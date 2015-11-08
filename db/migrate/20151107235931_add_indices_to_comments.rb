class AddIndicesToComments < ActiveRecord::Migration
  def up
    add_index :comments, [:user_id, :post_id]
  end

  def down
    remove_index :comments, [:user_id, :post_id]
  end
end
