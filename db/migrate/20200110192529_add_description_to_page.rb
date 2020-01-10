class AddDescriptionToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :description, :string
  end
end
