class PageForum < ApplicationRecord
	belongs_to :page
	has_many :users
	has_many :comments, dependent: :destroy
	has_many :users, through: :comments
	#has_many :comments

	# before_destroy :destroy_comments

	# private

	# def destroy_comments
	# 	self.comments.destroy
	# end

	#validates :title, :user_id, :page_id, presence: true
end
