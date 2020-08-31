class ChangeContentOnDrafts < ActiveRecord::Migration[6.0]
  def change
    change_column :drafts, :content, :text
  end
end
