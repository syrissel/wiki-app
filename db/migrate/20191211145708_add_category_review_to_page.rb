class AddCategoryReviewToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :category_review, :bigint
  end
end
