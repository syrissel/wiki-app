class ChangePathToStringOnImages < ActiveRecord::Migration[6.0]
  def change
    change_column :images, :path, :string
  end
end
