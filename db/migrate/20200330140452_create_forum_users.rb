class CreateForumUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :forum_users do |t|
      t.references :page_forum, null: true, foreign_key: true
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
