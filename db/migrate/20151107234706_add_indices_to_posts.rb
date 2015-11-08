class AddIndicesToPosts < ActiveRecord::Migration
  def up
    add_index :posts, :user_id
  end

  def down
    remove_index :posts, :user_id
  end
end
