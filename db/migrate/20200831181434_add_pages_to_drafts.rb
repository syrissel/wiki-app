class AddPagesToDrafts < ActiveRecord::Migration[6.0]
  def change
    add_reference :drafts, :page, null: false, foreign_key: true
  end
end
