class AddIndexToNotification < ActiveRecord::Migration[6.0]
  def change
    add_index :notifications, :recipient_id
    add_index :notifications, :actor_id
  end
end
