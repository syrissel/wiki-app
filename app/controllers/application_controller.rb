class ApplicationController < ActionController::Base

  before_action :set_layout_variables

  def set_layout_variables
    @makes = Make.all
    @pages = Page.all.order("updated_at desc")
  end

  private

  # Not exactly sure how helper_method works; revisit later.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_supervisor
    if current_user.nil?
      redirect_to login_path, alert: "Not authorized. Please login."
    elsif current_user.user_level_id == UserLevel.find_by_level('Intern').id 
      redirect_to login_path, alert: "Not authorized. Please find a supervisor to perform this action."
    end
  end

end
