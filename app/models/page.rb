class Page < ApplicationRecord
  belongs_to :approval_status
  belongs_to :user, optional: true
  belongs_to :category

end
