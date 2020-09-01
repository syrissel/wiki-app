class AddDescriptionToDrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :drafts, :description, :string
  end
end
