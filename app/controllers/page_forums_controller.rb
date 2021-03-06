class PageForumsController < ApplicationController

	def new
		
	end

	def index
		@page_forums = PageForum.all
	end

	def create
		@page_forum = PageForum.new(page_forum_params)

		if @page_forum.save
			# Update page object's foreign key so it has a reference.
			@page = Page.find(params[:page_forum][:page_id])
			@page.update(page_forum_id: @page_forum.id)
			redirect_to review_wiki_path(@page)
		else
			render :index
		end

	end

	def update
		@page_forum = PageForum.find(params[:id])
	end
	
	def show
		@page_forum = PageForum.find(params[:id])
		@comments = Comment.where(page_forum_id: @page_forum.id)
	end

	def refresh_forum
		@page_forum = PageForum.find(params[:id])
		render partial: 'page_forum', locals: { page_forum: @page_forum }
	end
	private

	def page_forum_params
		params.require(:page_forum).permit(:title, :page_id, :user_id)
	end
end
