class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      username: params[:name],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
    # @user = User.new(user_params)

    # if @user.save
    #   # session[:user_id] = @user.id
    #   redirect_to root_path, notice: "#{@user.username} has been created."
    # else
    #   render 'new'
    # end
  end

  private

  # def user_params
  #   params.require(:user).permit(:username, :password, :password_confirmation)
  # end
end
