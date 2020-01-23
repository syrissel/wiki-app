class AddBase64ToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :base64, :text, :limit => 4294967295
  end
end
