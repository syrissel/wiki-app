class Page < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :approval_status
  belongs_to :user, optional: true
	belongs_to :category
	belongs_to :page_publish_status
	has_one :page_forum, dependent: :destroy

  # Temp. Should change this later.
  paginates_per 5

	#validates :image, file_size: { less_than: 5.megabytes }
  validates :title, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :content, presence: true, length: { minimum: 3 }
  validates :category_id, presence: true



  def get_preview
    if content.index('<p>')
      preview_start = content.index('<p>')
      preview_end = content.index('</p>')
      preview = content[preview_start, preview_end]
      preview.length > 300 ? "#{ Page.strip_tags(preview[0..300]) }..." : "#{ Page.strip_tags(preview) }..."
      
    elsif content.index('<ul>')
      'ul'
    elsif content.index('<ol>')
      'ol'
    else
      'nil'
    end
  end
end
