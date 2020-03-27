class CommentsController < ApplicationController

	def show
		@comment = Comment.find(params[:id])
	end

	def new
	end

	def create
		@comment = Comment.new(comment_params)

		if @comment.save
			recipient = User.find_by_username(@comment.page_forum.page.last_user_edit)
			actor = User.find(params[:comment][:user_id])
			Notification.create(recipient_id: recipient.id, actor_id: actor.id, message: "New message from #{actor.username}!")
			flash[:notice] = 'Comment posted!'
		else
			redirect_to pages_path
		end
  end

  def update
  end

  def destroy
	end
	
	private

	def comment_params
		params.fetch(:comment, {}).permit(:title, :body, :user_id, :page_forum_id)
	end
end
