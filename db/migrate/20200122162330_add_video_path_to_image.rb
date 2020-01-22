class AddVideoPathToImage < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :video_path, :string
  end
end
