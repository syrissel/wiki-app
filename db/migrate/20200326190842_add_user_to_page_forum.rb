class AddUserToPageForum < ActiveRecord::Migration[6.0]
  def change
    add_reference :page_forums, :user, null: false, foreign_key: true
  end
end
