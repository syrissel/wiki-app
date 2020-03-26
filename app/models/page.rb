class Page < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :approval_status
  belongs_to :user, optional: true
	belongs_to :category
	belongs_to :page_publish_status
	has_one :page_forum

  paginates_per 6

	#validates :image, file_size: { less_than: 5.megabytes }
  validates :title, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :content, presence: true, length: { minimum: 3 }
  validates :category_id, presence: true
end
