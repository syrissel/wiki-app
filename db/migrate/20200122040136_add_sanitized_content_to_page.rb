class AddSanitizedContentToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :sanitized_content, :text
  end
end
