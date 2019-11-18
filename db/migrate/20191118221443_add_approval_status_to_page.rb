class AddApprovalStatusToPage < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :approval_status, null: false, foreign_key: true
  end
end
