class AddServerIpToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :server_ip, :string
  end
end
