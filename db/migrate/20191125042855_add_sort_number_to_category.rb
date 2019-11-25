class AddSortNumberToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :sort_number, :integer
  end
end
