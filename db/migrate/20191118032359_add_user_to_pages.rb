class AddUserToPages < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :user, null: true, foreign_key: true
  end
end
