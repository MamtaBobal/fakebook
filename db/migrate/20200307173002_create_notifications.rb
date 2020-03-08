class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :notice_id
      t.string :notice_type

      t.timestamps
    end
  end
end
