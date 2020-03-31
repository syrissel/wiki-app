class AddCascadeToPage < ActiveRecord::Migration[6.0]
	def up
		remove_reference :pages, :page_forum, null: true, foreign_key: true
		add_reference :pages, :page_forum, null: true, foreign_key: true, on_delete: :cascade
	end
	
	def down
		remove_reference :pages, :page_forum, null: true, foreign_key: true
		add_reference :pages, :page_forum, null: true, foreign_key: true
	end
end
