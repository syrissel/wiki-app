class Pdf < ApplicationRecord
  mount_uploader :path, PdfUploader

  validates :name, presence: true
  validates :path, presence: true

  paginates_per 7
end
