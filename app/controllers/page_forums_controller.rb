class PageForumsController < ApplicationController

	def new
		
	end

	def create
		@page_forum = PageForum.new(page_forum_params)

		@page_forum.save

	end
	
	def show
		@page_forum = PageForum.find(params(:id))
	end

	private

	def page_forum_params
		params.fetch(:page_forum, {}).permit(:title, :page_id, :user_id)
	end
end
