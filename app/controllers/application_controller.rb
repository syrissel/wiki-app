class ApplicationController < ActionController::Base
  before_action :set_layout_variables

  def set_layout_variables

    @menu_pages = Page.all
    @sub_categories = Category.order(:position).where("category_id IS NOT NULL")
		@root_categories = Category.order(:position).where("category_id IS NULL")
		@random_page = Page.where(page_publish_status_id: PUBLISHED).order('RAND()').first

    if current_user
			#@notifications = Notification.joins("INNER JOIN users ON users.id = notifications.recipient_id WHERE users.id = #{current_user.id}")
			@notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc)
			@unread_notifications = @notifications.where('read_at IS NULL')
    else
      @notifications = nil
    end


  end

	private
	
	def get_message_time(post_time)
		minutes = ((Time.now - post_time)/60).round
		hours = ((Time.now - post_time)/3600).round
		days = ((Time.now - post_time)/86400).round
		years = ((Time.now - post_time)/31536000).round

		result = nil

		if years > 0
			result = "#{helpers.pluralize(years, 'year')}"
		elsif days > 0
			result = "#{helpers.pluralize(days, 'day')}"
		elsif hours > 0
			result = "#{helpers.pluralize(hours, 'hour')}"
		elsif minutes > 0
			result = "#{helpers.pluralize(minutes, 'minute')}"
		else
			result = "#{helpers.pluralize((Time.now - post_time).round, 'second')}"
		end

		result
	end
	helper_method :get_message_time

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # Need to revise these two methods
  def authenticate_supervisor
    if current_user.nil?
      redirect_to login_path, notice: "Not authorized. Please login."
    elsif current_user.user_level_id == INTERN_VALUE
      redirect_to root_path, notice: "Not authorized. Please find a supervisor to perform this action."
    end
	end

  def authenticate_user
    redirect_to login_path, alert: "Please login to view content." if current_user.nil?
  end
  
  def authorize_access
    current_user.user_level_id != INTERN_VALUE unless current_user.nil?
  end
  helper_method :authorize_access

  

end
