class AddPinnedToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :status, :string
  end
end
