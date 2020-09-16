class AddGlobalPinnedToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :global_pinned, :string
  end
end
