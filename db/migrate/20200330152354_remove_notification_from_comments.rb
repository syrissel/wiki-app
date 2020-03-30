class RemoveNotificationFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :comments, :notification, null: false, foreign_key: true
  end
end
