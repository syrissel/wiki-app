class AddPageToModel2 < ActiveRecord::Migration[6.0]
  def change
    add_reference :models, :page, null: false, foreign_key: true
  end
end
