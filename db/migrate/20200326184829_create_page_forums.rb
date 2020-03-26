class CreatePageForums < ActiveRecord::Migration[6.0]
  def change
    create_table :page_forums do |t|
      t.string :title

      t.timestamps
    end
  end
end
