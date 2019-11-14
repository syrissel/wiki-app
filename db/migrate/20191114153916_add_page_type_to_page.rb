class AddPageTypeToPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :page_type, null: false, foreign_key: true
  end
end
