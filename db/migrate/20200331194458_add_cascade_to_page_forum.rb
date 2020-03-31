class AddCascadeToPageForum < ActiveRecord::Migration[6.0]
	def change
		remove_reference :page_forums, :page
		add_reference :page_forums, :page, null: true, foreign_key: {on_delete: :cascade}
  end
end
