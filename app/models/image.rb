class Image < ApplicationRecord
  has_many :videos
  mount_uploader :path, ImageUploader
end
