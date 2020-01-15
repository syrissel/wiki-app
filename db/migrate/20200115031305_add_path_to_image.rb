class AddPathToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :path, :string
  end
end
