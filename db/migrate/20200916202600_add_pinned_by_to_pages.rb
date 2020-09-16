class AddPinnedByToPages < ActiveRecord::Migration[6.0]
  def up
    add_reference :pages, :pinned_by, foreign_key: { to_table: :users }
  end
  def down
    remove_reference :pages, :pinned_by, foreign_key: { to_table: :users }
  end
end
