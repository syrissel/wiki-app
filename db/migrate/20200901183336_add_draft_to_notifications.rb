class AddDraftToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :draft, null: true, foreign_key: true
  end
end
