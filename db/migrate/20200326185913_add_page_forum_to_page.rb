class AddPageForumToPage < ActiveRecord::Migration[6.0]
	def change
		add_reference :pages, :page_forum, null: true, foreign_key: true, on_delete: :cascade
  end
end
