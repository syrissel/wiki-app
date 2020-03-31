class AddCascadeToPages < ActiveRecord::Migration[6.0]
	def change
		remove_reference :pages, :page_forum
		add_reference :pages, :page_forum, foreign_key: { on_delete: :cascade }
  end
end
