class Draft < ApplicationRecord
  belongs_to :category
  belongs_to :approval_status
  belongs_to :page
  belongs_to :user

  paginates_per 20

  validates :title, presence: true, length: { maximum: 40 }
  validates :category_id, presence: true
end
