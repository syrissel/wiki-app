class AddVideoIdToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :video_id, :int, null: true
  end
end
