class ApplicationController < ActionController::Base
  before_action :set_layout_variables

  def set_layout_variables
    @makes = Make.all
    @pages = Page.all.order("updated_at desc")
    @prod_pages = Page.where(page_type_id: 1)
    @page_types = PageType.all

    # @pages_of_type_array = []

    # @page_types.each do |pt|
    #   pages_of_type = @pages.find(pt.id)
    #   @pages_of_type_array.push(pages_of_type)
    # end

    

    # for i in @page_types do
    #   @page_types[i]
    # end
  end

  private

  # Not exactly sure how helper_method works; revisit later.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  # Need to revise these two methods
  def authenticate_supervisor
    if current_user.nil?
      redirect_to login_path, alert: "Not authorized. Please login."
    elsif current_user.user_level_id == INTERN_VALUE
      redirect_to root_path, alert: "Not authorized. Please find a supervisor to perform this action."
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
