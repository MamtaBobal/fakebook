class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :sent_to_id
      t.integer :sent_by_id
      t.boolean :status

      t.timestamps
    end
  end
end
