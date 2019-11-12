class AddMakeToModel < ActiveRecord::Migration[6.0]
  def change
    add_reference :models, :make, null: false, foreign_key: true
  end
end
