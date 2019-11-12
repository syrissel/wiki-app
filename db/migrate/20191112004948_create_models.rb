class CreateModels < ActiveRecord::Migration[6.0]
  def change
    create_table :models do |t|
      t.string :name
      t.string :series
      t.string :type

      t.timestamps
    end
  end
end
