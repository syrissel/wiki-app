class RemovePageFromModel < ActiveRecord::Migration[6.0]
  def change
    remove_reference :models, :page, null: false, foreign_key: true
  end
end
