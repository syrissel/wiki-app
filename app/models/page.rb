class Page < ApplicationRecord
  belongs_to :approval_status
  belongs_to :user, optional: true
  belongs_to :category

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { minimum: 3 }
end
