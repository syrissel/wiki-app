class AddPositionToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :position, :integer
  end
end
