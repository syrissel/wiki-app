class Page < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :approval_status
  belongs_to :user, optional: true
  belongs_to :category

	validates :image, file_size: { less_than: 5.megabytes }
  validates :title, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :content, presence: true, length: { minimum: 3 }
end
