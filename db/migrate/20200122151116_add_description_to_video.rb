class AddDescriptionToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :description, :text
  end
end
