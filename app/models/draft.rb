class Draft < ApplicationRecord
  belongs_to :category
  belongs_to :approval_status
  belongs_to :page
  belongs_to :user
  has_many :notifications

  paginates_per 20

  validates :title, presence: true, length: { maximum: 40 }
  validates :category_id, presence: true
  validates :description, presence: true

  scope :supervisor_approved_first, -> { order("FIELD(approval_status_id, #{SUPERVISOR_VALUE}) DESC") }
end
