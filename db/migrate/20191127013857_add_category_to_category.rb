class AddCategoryToCategory < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :sub_category, null: true, foreign_key: true
  end
end
