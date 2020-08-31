class CreateDrafts < ActiveRecord::Migration[6.0]
  def change
    create_table :drafts do |t|
      t.string :title
      t.string :content
      t.references :category, null: false, foreign_key: true
      t.references :approval_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
