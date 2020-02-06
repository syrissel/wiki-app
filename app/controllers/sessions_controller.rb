class SessionsController < ApplicationController
  def new
  end

  # Redirect if username/pw combination is wrong & user refreshes page.
  def index
    redirect_to root_path
  end

  def create
    user = User.find_by_username(params["/sessions"][:username])

		if (user.user_status_id == UserStatus.last.id)
			flash.now.alert = "User has been offboarded by an administrator."
			render 'new'
		elsif user && user.authenticate(params["/sessions"][:password])
      session[:user_id] = user.id
      user.update_attribute(:last_login, Time.now)
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now.alert = "Username/password combination is invalid."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
