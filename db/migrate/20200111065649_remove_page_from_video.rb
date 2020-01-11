class RemovePageFromVideo < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :page_id
  end
end
