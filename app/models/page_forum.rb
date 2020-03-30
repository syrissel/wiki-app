class PageForum < ApplicationRecord
	has_one :page
	has_many :users
	has_many :comments
	has_many :users, through: :comments
	#has_many :comments

	#validates :title, :user_id, :page_id, presence: true
end
