class AddContentReviewToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :content_review, :text
  end
end
