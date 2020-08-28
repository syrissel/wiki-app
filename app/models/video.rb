class Video < ApplicationRecord
  # belongs_to :page, optional: true
  belongs_to :image, optional: true

	mount_uploader :path, VideoUploader
	
  paginates_per 8
  
  validates :name, presence: true
  validates :path, presence: true


  # def set_success(format, opts)
  #   self.success = true
  # end
end
