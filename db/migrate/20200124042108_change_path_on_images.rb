class ChangePathOnImages < ActiveRecord::Migration[6.0]
  def change
    change_column :images, :path, :text, :limit => 4294967295
  end
end
