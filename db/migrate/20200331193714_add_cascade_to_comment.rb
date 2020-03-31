class AddCascadeToComment < ActiveRecord::Migration[6.0]
	def change
		remove_reference :notifications, :comment
		add_reference :notifications, :comment, null: true, foreign_key: { on_delete: :cascade }
  end
end
