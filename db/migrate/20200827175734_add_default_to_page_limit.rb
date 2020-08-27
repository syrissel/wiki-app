class AddDefaultToPageLimit < ActiveRecord::Migration[6.0]
  def change
    change_column :categories, :page_limit, :int, default: 20
  end
end
