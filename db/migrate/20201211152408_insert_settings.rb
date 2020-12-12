class InsertSettings < ActiveRecord::Migration[6.0]
  def up
    Setting.create(logo: 'Wiki App')
  end

  def down
    Setting.delete_all
  end
end
