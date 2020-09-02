class AddCommentsToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :comments, :text
  end
end
