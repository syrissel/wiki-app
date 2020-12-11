class RemoveSmtpDomainFromSettings < ActiveRecord::Migration[6.0]
  def change
    remove_column :settings, :smtp_domain
  end
end
