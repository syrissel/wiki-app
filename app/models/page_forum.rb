class PageForum < ApplicationRecord
	has_one :page
	belongs_to :user
	has_many :comments

	#validates :title, :user_id, :page_id, presence: true
end
