class AddApprovedByToPages < ActiveRecord::Migration[6.0]
  def up
    add_reference :pages, :approved_by, foreign_key: { to_table: :users }
  end
  def down
    remove_reference :pages, :approved_by, foreign_key: { to_table: :users }
  end
end
