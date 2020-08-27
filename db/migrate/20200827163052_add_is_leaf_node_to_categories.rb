class AddIsLeafNodeToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :is_leaf_node, :string
  end
end
