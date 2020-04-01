class CommentsController < ApplicationController

	def show
		@comment = Comment.find(params[:id])
	end

	def new
	end

	def create
		@comment = Comment.new(comment_params)

		if @comment.save
			# recipient = User.find_by_username(@comment.page_forum.page.last_user_edit)
			#actor = User.find(params[:comment][:user_id])
			@page_forum = PageForum.find(@comment.page_forum_id)
			#@forum_users = User.uniq.joins(:comments).where(comments: {id: @comment.page_forum.comment_ids}).reject {|user| user == current_user }

			# If there's currently no users subscribed to the thread, just notify the user who submitted the wiki.
			# Otherwise, notify every user who has commented on the thread.
			if (@page_forum.users.uniq - [current_user]).count < 1
				Notification.create(recipient_id: User.find_by_username(@page_forum.page.last_user_edit).id, actor_id: current_user.id, message: "New message from #{current_user.username} in #{@page_forum.title}!", 
														comment_id: @comment.id, page_id: @page_forum.page.id)
			else
				(@page_forum.users.uniq - [current_user]).each do |user|
					Notification.create(recipient_id: user.id, actor_id: current_user.id, message: "New message from #{current_user.username} in #{@page_forum.title}!", 
															comment_id: @comment.id, page_id: @page_forum.page.id)
				end
			end

			#notification = Notification.create(recipient_id: recipient.id, actor_id: actor.id, message: "New message from #{actor.username}!", comment_id: @comment.id)
			#@comment.update(notification_id: notification.id)
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
		params.fetch(:comment, {}).permit(:title, :body, :user_id, :page_forum_id, :notification_id)
	end
end
