class AddPageLimitToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :page_limit, :int
  end
end
