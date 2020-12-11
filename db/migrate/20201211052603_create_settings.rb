class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      # t.references :logo, null: true, foreign_key: { to_table: :images }
      t.string :logo
      t.string :smtp_address
      t.string :smtp_port
      t.string :smtp_domain
      t.string :smtp_username
      t.string :smtp_password

      t.timestamps
    end
  end
end
