class Page < ApplicationRecord
	mount_uploader :image, ImageUploader
  belongs_to :approval_status
  belongs_to :user, optional: true
  belongs_to :pinned_by, class_name: 'User', foreign_key: :pinned_by_id, optional: true
  belongs_to :category_pinned_by, class_name: 'User', foreign_key: :category_pinned_by_id, optional: true
  belongs_to :approved_by, class_name: 'User', foreign_key: :approved_by_id, optional: true
	belongs_to :category
	belongs_to :page_publish_status
  has_one :page_forum, dependent: :destroy
  has_many :drafts

  # Temp. Should change this later.
  paginates_per 5

	#validates :image, file_size: { less_than: 5.megabytes }
  validates :title, presence: true, length: { maximum: 40 }
  validates :category_id, presence: true



  def get_preview
    result = ''
    doc = Nokogiri::HTML(content)

    # Remove nodes not needed for preview.
    doc.search("//div").remove
    doc.search("//h1").remove
    doc.search("//h2").remove
    doc.search("//h3").remove
    doc.search("//h4").remove
    doc.search("//h5").remove
    doc.search("//h6").remove
    doc.search("//img").remove
    doc.search("//ul").remove
    doc.search("//ol").remove

    # Loop through text of remaining nodes.
    doc.xpath("//text()").each do |node|
      result += "#{node.to_s} "
    end
    result[0..300].strip + '...'
  end

  scope :global, -> { order(global_pinned: :desc).order(last_edited_at: :desc).order(updated_at: :desc) }
  scope :pinned_categories, -> { order(category_pinned: :desc).order(last_edited_at: :desc).order(updated_at: :desc) }
end
