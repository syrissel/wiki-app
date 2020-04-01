class AddCascadeToNotification < ActiveRecord::Migration[6.0]
	def change
		remove_reference :notifications, :page
		add_reference :notifications, :page, null: true, foreign_key: { on_delete: :cascade }
  end
end
