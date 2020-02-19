class Image < ApplicationRecord
  has_many :videos
	mount_uploader :path, ImageUploader
	mount_base64_uploader :video_path, ImageUploader

	validates :name, presence: true, uniqueness: { case_sensitive: true }
	validates :path, presence: true, unless: ->(image){image.video_path.present?}
	validates :video_path, presence: true, unless: ->(image){image.path.present?}

	paginates_per 12
end
