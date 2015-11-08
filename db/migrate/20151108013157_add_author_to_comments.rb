class AddAuthorToComments < ActiveRecord::Migration
  def up
    add_column :comments, :author, :string
  end

  def down
    remove_column :comments, :author
  end
end
