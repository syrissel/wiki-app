class CreatePagePublishStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :page_publish_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
