class AddCategoryPinnedToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :category_pinned, :string
  end
end
