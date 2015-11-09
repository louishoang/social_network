class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false
      t.string :status, null: false, default: "Pending"

      t.timestamps
    end
  end
end
