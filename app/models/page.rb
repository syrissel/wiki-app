class Page < ApplicationRecord
  belongs_to :approval_status
  belongs_to :user
  belongs_to :page_type
end
