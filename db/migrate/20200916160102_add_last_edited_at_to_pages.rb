class AddLastEditedAtToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :last_edited_at, :datetime
  end
end
