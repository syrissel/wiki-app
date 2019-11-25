class AddCategoryToPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :category, null: false, foreign_key: true
  end
end
