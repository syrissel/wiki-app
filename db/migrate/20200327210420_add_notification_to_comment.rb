class AddNotificationToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :notification, null: true, foreign_key: true
  end
end
