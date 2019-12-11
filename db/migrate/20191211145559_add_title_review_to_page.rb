class AddTitleReviewToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :title_review, :string
  end
end
