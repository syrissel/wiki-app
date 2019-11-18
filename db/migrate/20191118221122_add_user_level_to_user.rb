class AddUserLevelToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :user_level, null: false, foreign_key: true
  end
end
