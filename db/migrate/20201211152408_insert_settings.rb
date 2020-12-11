class InsertSettings < ActiveRecord::Migration[6.0]
  def up
    Setting.create(logo: 'Computers for Schools')
  end

  def down
    Setting.delete_all
  end
end
