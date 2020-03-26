class PageForum < ApplicationRecord
	has_one :page
	belongs_to :user
	has_many :comments
end
