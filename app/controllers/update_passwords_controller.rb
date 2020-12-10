class UpdatePasswordsController < ApplicationController
  before_action :authenticate_user
  before_action :is_intern
  before_action :authenticate_supervisor

  def new
    @update_password_form = UpdatePasswordForm.new(User.find(params[:id]))
    @user = User.find(params[:id])
  end

  def create
    @update_password_form = UpdatePasswordForm.new(User.find(params[:id]))

    if @update_password_form.submit(params[:update_password_form])
      redirect_to root_path, notice: 'Password changed.'
    else
      render :new
    end
  end

  private

  def is_intern
    user = User.find(params[:id])
    if user.user_level_id > INTERN_VALUE
      redirect_to edit_user_path(user), alert: 'Cannot change the password of a supervisor.'
    end
  end
end