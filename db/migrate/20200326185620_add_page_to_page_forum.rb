class AddPageToPageForum < ActiveRecord::Migration[6.0]
	def change
		add_reference :page_forums, :page, null: true, foreign_key: true, on_delete: :nullify
  end
end
