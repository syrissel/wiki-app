class AddCommentsToDrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :drafts, :comments, :text
  end
end
