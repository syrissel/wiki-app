class SessionsController < ApplicationController
  def new
  end

  # Redirect if username/pw combination is wrong & user refreshes page.
  def index
    redirect_to root_path
  end

  def create
    user = User.find_by_username(params["/sessions"][:username])

	if user.present? && (user.user_status_id == UserStatus.last.id)
			flash.now.alert = "User has been offboarded by an administrator."
			render 'new'
		elsif user.present? && user.authenticate(params["/sessions"][:password])
      session[:user_id] = user.id
      user.update_attribute(:last_login, Time.now)
      flash['notice'] = 'Logged in successfully'
      if session[:page].present?
        page = Page.find(session[:page])
        session[:page] = nil
        redirect_to page_path(page)
      elsif session[:review_wiki].present?
        page = Page.find(session[:review_wiki])
        session[:review_wiki] = nil
        if user.user_level_id > INTERN_VALUE
          redirect_to review_wiki_path(page)
        else
          flash['alert'] = 'Unauthorized'
          redirect_to root_path
        end
      else
        redirect_to root_path
      end
    else
      flash.now.alert = "Username/password combination is invalid."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:page] = nil
    session[:review_wiki] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
