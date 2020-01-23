class Image < ApplicationRecord
  has_many :videos
	#mount_uploader :path, ImageUploader
	mount_base64_uploader :video_path, ImageUploader
end
