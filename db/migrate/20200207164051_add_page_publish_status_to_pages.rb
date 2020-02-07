class AddPagePublishStatusToPages < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :page_publish_status, null: false, foreign_key: true
  end
end
