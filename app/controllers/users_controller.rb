class UsersController < ApplicationController
  before_action :authenticate_supervisor, only: [:new]

  # What does this do?
  wrap_parameters :user, include: [:username, :password, :password_confirmation]

  def index
    @users = User.order(:username)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # session[:user_id] = @user.id
      redirect_to root_path, notice: "#{@user.username} has been created."
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :user_level_id)
  end
end
