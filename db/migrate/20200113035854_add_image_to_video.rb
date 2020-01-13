class AddImageToVideo < ActiveRecord::Migration[6.0]
  def change
    add_reference :videos, :image, null: true, foreign_key: true
  end
end
