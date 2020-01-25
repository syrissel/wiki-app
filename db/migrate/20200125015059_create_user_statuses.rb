class CreateUserStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
