class AddUserStatusToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :user_status, null: false, foreign_key: true
  end
end
