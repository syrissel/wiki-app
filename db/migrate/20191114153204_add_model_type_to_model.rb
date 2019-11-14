class AddModelTypeToModel < ActiveRecord::Migration[6.0]
  def change
    add_reference :models, :model_type, null: false, foreign_key: true
  end
end
