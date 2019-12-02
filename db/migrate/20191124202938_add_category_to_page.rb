class AddCategoryToPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :category, null: false, foreign_key: true, on_delete: :cascade
  end
end
