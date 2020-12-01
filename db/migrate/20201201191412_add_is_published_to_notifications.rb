class AddIsPublishedToNotifications < ActiveRecord::Migration[6.0]
  def up
    add_column :notifications, :is_published, :string, null: true
  end
  def down
    remove_column :notifications, :is_published, :string, null: true
  end
end
