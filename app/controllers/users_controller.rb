class UsersController < ApplicationController
  before_action :authenticate_supervisor, only: [:new, :index]

  # What does this do?
  wrap_parameters :user, include: [:username, :password, :password_confirmation]

  def index
    @users = User.order(:username)
  end

  def new
    @user = User.new
    @active = UserStatus.find_by_status('Active').id
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "#{@user.username} has been created."
    else
      render 'new'
    end
	end
	
	

  def destroy
    @user = User.find(params[:id])
    redirect_to users_path, notice: "#{@user.username} has been deleted."
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :user_level_id, :first_name, :last_name, :user_status_id)
  end
end
