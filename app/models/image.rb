class Image < ApplicationRecord
  belongs_to :video

  mount_uploader :image, ImageUploader
end
