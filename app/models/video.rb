class Video < ApplicationRecord
  # belongs_to :page, optional: true
  has_one :image

  mount_uploader :path, VideoUploader


  # def set_success(format, opts)
  #   self.success = true
  # end
end
