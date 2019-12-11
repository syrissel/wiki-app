class AddLastUserEditToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :last_user_edit, :string
  end
end
