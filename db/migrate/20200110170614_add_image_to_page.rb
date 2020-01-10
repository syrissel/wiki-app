class AddImageToPage < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :image, :string
  end
end
