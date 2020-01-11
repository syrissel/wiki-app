class Video < ApplicationRecord
  # belongs_to :page, optional: true

  mount_uploader :path, VideoUploader

  # def set_success(format, opts)
  #   self.success = true
  # end
end
